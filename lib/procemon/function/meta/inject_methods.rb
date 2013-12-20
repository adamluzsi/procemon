class Class

  #TODO refacotr to binding logic because this is useless now to me in hardcore use

  # this will inject a code block to a target instance method
  # by default the before or after sym is not required
  # default => before
  #
  #  Test.inject_singleton_method :hello do |*args|
  #    puts "singleton extra, so #{args[0]}"
  #  end
  #
  def inject_singleton_method(method,options=:before,&block)

    original_method= self.method(method).clone
    #Singleton.methods[self.object_id]= self.method(method)
    self.singleton_class.__send__ :undef_method, method
    self.class_eval do
      define_singleton_method method do |*arguments|

        if options == :before
          block.call_with_binding self.get_binding, *arguments
        end

        original_method.call *arguments

        if options == :after
          block.call_with_binding self.get_binding, *arguments
        end

      end
    end

  end

  # this will inject a code block to a target singleton method
  # by default the before or after sym is not required
  # default => before
  #
  #  Test.inject_instance_method :hello, :before do |*args|
  #    puts "singleton on a instance method and "+args[0]
  #  end
  #
  def inject_instance_method(method,options=:before,&block)
    self.class_eval do
      alias_method :"old_#{method.to_s}", method
    end
    extended_process = Proc.new do |*args|

      case true

        when options == :before
          begin
            block.call_with_binding self.get_binding, *args
            self.__send__ :"old_#{method.to_s}", *args
          end

        when options == :after
          begin
            self.__send__ :"old_#{method.to_s}", *args
            block.call_with_binding self.get_binding, *args
          end

      end

    end
    self.class_eval do
      define_method method, extended_process#Proc call
    end
  end

end