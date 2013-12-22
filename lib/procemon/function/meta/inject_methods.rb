class Class

  # this will inject a code block to a target instance method
  # by default the before or after sym is not required
  # default => before
  #
  #  Test.inject_singleton_method :hello do |*args|
  #    puts "singleton extra, so #{args[0]}"
  #  end
  #
  def inject_singleton_method(method,options=:before,&block)

    puts block.source


    original_method= self.method(method).clone
    #Singleton.methods[self.object_id]= self.method(method)
    self.singleton_class.__send__ :undef_method, method
    self.class_eval do
      define_singleton_method method do |*arguments|

        if options == :before
          block.source.to_proc(self.binding?).call *arguments
        end

        original_method.call *arguments

        if options == :after
          block.source.to_proc(self.binding?).call *arguments
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

      if options == :before
        block.source.to_proc(self.binding?).call *args
      end

      self.__send__ :"old_#{method.to_s}", *args

      if options == :after
        block.source.to_proc(self.binding?).call *args
      end

    end
    self.class_eval do
      define_method method, extended_process#Proc call
    end
  end

end