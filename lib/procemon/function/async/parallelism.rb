# now let's see the Parallelism
# you can use simple :p also instead of :parallelism
# remember :parallelism is all about real OS thread case, so
# you CANT modify the objects in memory only copy on write modify
# This is ideal for big operations where you need do a big process
# and only get the return value so you can do big works without the fear of the
# Garbage collector slowness or the GIL lock
# when you need to update objects in the memory use :concurrency
class Parallelism < CleanClass

  # Basic
  begin

    require 'yaml'
    @@pids=[]
    def initialize callable

      @value= nil
      @rd, @wr = ::IO.pipe
      @pid= ::Kernel.fork do

        ::Kernel.trap("TERM") do
          puts "hy"
          exit
        end

        @rd.close
        @wr.write callable.call.to_yaml
        @wr.close

      end

      @@pids.push(@pid)

    end

  end

  # return value
  begin

    def value

      if @value.nil?

        @wr.close
        return_value= @rd.read
        begin
          return_value= ::YAML.load(return_value)
        rescue ::Exception
        end
        @rd.close
        @@pids.delete(@pid)
        @value= return_value

      end

      return @value

    end


    def value=(obj)
      @value= obj
    end

    #def method_missing(method,*args)
    #  value.__send__(method,*args)
    #end
    #
    #def respond_to_missing?(method, include_private = false)
    #  value.respond_to?(method, include_private)
    #end

  end

  # kill Zombies at Kernel Exit
  begin
    ::Kernel.at_exit {
      @@pids.each { |pid|
        begin
          ::Process.kill(:TERM, pid)
        rescue ::Errno::ESRCH, ::Errno::ECHILD
          ::STDOUT.puts "`kill': No such process (Errno::ESRCH)"
        end
      }
    }
  end

end