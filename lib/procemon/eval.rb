module Procemon::ObjectEXT

    # safe_eval(string [, binding [, filename [,lineno]]] *allowed_class/module_names )  -> obj
    #
    # Definition of the safe levels
    #
    # $SAFE >= 1
    #
    # The environment variables RUBYLIB and RUBYOPT are not processed, and the current directory is not added to the path.
    #                                                                                                                    The command-line options -e, -i, -I, -r, -s, -S, and -x are not allowed.
    #     Can't start processes from $PATH if any directory in it is world-writable.
    #     Can't manipulate or chroot to a directory whose name is a tainted string.
    #                                                                                       Can't glob tainted strings.
    #     Can't eval tainted strings.
    #                                                                                                                          Can't load or require a file whose name is a tainted string.
    #     Can't manipulate or query the status of a file or pipe whose name is a tainted string.
    #                                                                                                                                                                                                                         Can't execute a system command or exec a program from a tainted string.
    #     Can't pass trap a tainted string.
    #
    #                                                                                                                                                                                                                                                               $SAFE >= 2
    #
    # Can't change, make, or remove directories, or use chroot.
    #     Can't load a file from a world-writable directory.
    #     Can't load a file from a tainted filename starting with ~.
    #     Can't use File#chmod , File#chown , File#lstat , File.stat , File#truncate , File.umask , File#flock , IO#ioctl , IO#stat , Kernel#fork , Kernel#syscall , Kernel#trap . Process::setpgid , Process::setsid , Process::setpriority , or Process::egid= .
    # Can't handle signals using trap.
    #
    # $SAFE >= 3
    #
    #     All objects are created tainted.
    #     Can't untaint objects.
    #
    #
    # Evaluates the Ruby expression(s) in <em>string</em>. If
    # <em>binding</em> is given, which must be a <code>Binding</code>
    # object, the evaluation is performed in its context. If the
    # optional <em>filename</em> and <em>lineno</em> parameters are
    # present, they will be used when reporting syntax errors.
    #
    #    def get_binding(str)
    #      return binding
    #    end
    #    str = "hello"
    #    safe_eval "str + ' Fred'" ,Kernel                      #=> "hello Fred"
    #    safe_eval "str + ' Fred'", get_binding("bye") ,Kernel  #=> "bye Fred"
    def safe_eval(*args)

      # require 'stringio'
      # old_values = [$stderr,$VERBOSE]
      # $stderr = StringIO.new
      # $VERBOSE= false

      ::Thread.new{

        safe_ok= false
        begin
          $SAFE= 3
          safe_ok= true
        rescue
        end
        if safe_ok
          eval(*args)
        end

      }.value

    # ensure
      # $stderr = old_values[0]
      # $VERBOSE= old_values[1]

    end

end

Object.__send__ :include, Procemon::ObjectEXT