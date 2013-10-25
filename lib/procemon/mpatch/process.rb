module Process
  def self.daemonize
    File.create Application.pid,'a+'
    File.create Application.log,'a+'
    File.create Application.daemon_stderr,'a+'
    Daemon.start fork,
                 Application.pid,
                 Application.log,
                 Application.daemon_stderr
  end
  def self.stop
    Daemon.stop
  end
end