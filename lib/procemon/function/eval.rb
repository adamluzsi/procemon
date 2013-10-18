module Kernel

  # safe_eval(string [, binding [, filename [,lineno]]] *allowed_class/module_names )  -> obj
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

    # defaults
    begin
      allowed=  Array.new
      eval_exception= String.new
      tmp_array= nil
    end

    # separate allowed names
    begin
      tmp_array= Array.new
      args.each do |argument|
        case argument.class.to_s.downcase

          when "class","module"
            begin
              allowed.push argument
            end

          else
            begin
              tmp_array.push argument
            end

        end
      end
      args= tmp_array
    end

    # build exception list to eval
    begin
      allowed.each do |one_name|
        eval_exception += "|"+one_name.to_s
      end
    end

    # trim un wanted elements from string
    begin
      args.each do |argument|
        case argument.class.to_s.downcase

          when "string"
            begin
              #TODO new regex!  # /(\b|\.|\{|\>)[A-Z]\w*/
              #args[args.index(argument)]= argument.gsub( /(\b|\.|\{|\>)[A-Z]\w*/ ,'')
            end

        end
      end
    end

    # do save eval
    begin
      eval(*args)
    end

  end if $DEBUG == true

end
