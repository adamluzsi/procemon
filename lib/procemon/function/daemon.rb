# use Daemon.daemonize or Process.daemonize
class Daemon

  # Checks to see if the current process is the child process and if not
  # will update the pid file with the child pid.
  def self.start pid, pidfile, outfile, errfile
    unless pid.nil?
      raise "Fork failed" if pid == -1
      write pid, pidfile #if kill pidfile
      exit
    else
      redirect outfile, errfile
    end
  end

  # Attempts to write the pid of the forked process to the pid file.
  def self.write pid, pidfile
    File.create(pidfile,"w","") if File.exists?(Application.pid)
    File.open pidfile, "a+" do |new_line|
      new_line.write "#{pid}\n"
    end
  rescue ::Exception => e
    $stderr.puts "While writing the PID to file, unexpected #{e.class}: #{e}"
    Process.kill "HUP", pid
  end

  # Try and read the existing pid from the pid file and signal the
  # process. Returns true for a non blocking status.
  def self.kill(pidfile)
    opid = File.open(File.join".",pidfile).read.strip.to_i
    Process.kill 'HUP', opid.to_i
    true
  rescue Errno::ENOENT
    $stdout.puts "#{pidfile} did not exist: Errno::ENOENT"                        if $DEBUG
    true
  rescue Errno::ESRCH
    $stdout.puts "The process #{opid} did not exist: Errno::ESRCH"                if $DEBUG
    true
  rescue Errno::EPERM
    $stderr.puts "Lack of privileges to manage the process #{opid}: Errno::EPERM" if $DEBUG
    false
  rescue ::Exception => e
    $stderr.puts "While signaling the PID, unexpected #{e.class}: #{e}"           if $DEBUG
    false
  end

  # Send stdout and stderr to log files for the child process
  def self.redirect outfile, errfile
    $stdin.reopen File.join('','dev','null')
    out = File.new outfile, "a"
    err = File.new errfile, "a"
    $stdout.reopen out
    $stderr.reopen err
    $stdout.sync = $stderr.sync = true
  end

  def self.daemonize

    pid_path= nil
    log_path= nil
    daemon_stderr= nil

    begin
      File.create Application.pid,'a+'
      File.create Application.log,'a+'
      File.create Application.daemon_stderr,'a+'

      pid_path= Application.pid
      log_path= Application.log
      daemon_stderr= Application.daemon_stderr
    rescue Exception
      File.create File.join(Dir.pwd, "pid", "pidfile" ),'a+'
      File.create File.join(Dir.pwd, "log", "logfile" ),'a+'
      File.create File.join(Dir.pwd, "log", "daemon_stderr" ),'a+'

      pid_path= File.join(Dir.pwd, "pid", "pidfile" )
      log_path= File.join(Dir.pwd, "log", "logfile" )
      daemon_stderr= File.join(Dir.pwd, "log", "daemon_stderr" )
    end

    Daemon.start(fork,pid_path,log_path,daemon_stderr)

  end

  def self.kill_with_pid
    begin
      if File.exists?(Application.pid)
        puts "PidFile found, processing..."  if $DEBUG
        File.open(Application.pid).each_line do |row|
          begin
            Process.kill 'TERM', row.chomp.to_i
            puts "terminated process at: #{row.chomp}" if $DEBUG
          rescue Exception => ex
            puts "At process: #{row.chomp}, #{ex}"     if $DEBUG
          end
        end
      else
        system "ps -ef | grep #{$0}"
        #system "netstat --listen"
        #puts "\nLepton is around 10300-10399"
      end
    rescue Exception => ex
      puts "Exception has occured: #{ex}"
    end
  end

  def self.terminate
    Daemon.kill Application.pid
    Daemon.kill_with_pid
  end

  def self.kill_by_name(*args)

    target_name= nil
    debug_mod  = false

    args.each do |one_element|
      if one_element.class == String
        target_name = one_element
      elsif one_element.class == TrueClass || one_element.class == FalseClass
        debug_mod = one_element
      end
    end

    # name switch
    begin
      target_name ||= $0
      $0 = "ruby_tmp_process"
    end

    start_time= Time.now
    while `ps aux | grep #{target_name}`.split(' ')[1] != ""  ||(Time.now - start_time) < 6

      begin

        Process.kill "TERM",`ps aux | grep #{target_name}`.split(' ')[1].to_i

      rescue Errno::ESRCH
        $stdout.puts "The process #{target_name} did not exist: Errno::ESRCH"                if debug_mod
        break
      rescue Errno::EPERM
        $stderr.puts "Lack of privileges to manage the process #{target_name}: Errno::EPERM" if debug_mod
        break
      rescue ::Exception => e
        $stderr.puts "While signaling the PID, unexpected #{e.class}: #{e}"           if debug_mod
        break
      end
    end


    # name switch back
    begin
      $0 = target_name
    end

    return nil
  end

  def self.stop

    # kill methods
    begin
      self.kill_by_name true
      self.terminate
    end

    pid_path= nil
    begin
      pid_path= Application.pid
    rescue Exception
      pid_path= File.join(Dir.pwd, "pid", "pidfile" )
    end

    File.open(pid_path, "w").write("")
    Process.exit!

  end

  def self.init
    case Application.daemon.to_s.downcase
      when "true","start"
        self.daemonize
      when "stop"
        self.stop
    end
  end

end
