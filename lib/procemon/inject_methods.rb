module InjectMethods

  # this will inject a code block to a target instance method
  # by default the before or after sym is not required
  #
  # options can be:
  #  - add: 'before'/'after' add your code into method before the original part of after
  #
  #  Test.inject_singleton_method :hello do |*args|
  #    puts "singleton extra, so #{args[0]}"
  #  end
  #
  def inject_singleton_method(method,options={},&block)

    original_method= self.method(method).clone
    self.singleton_class.__send__ :undef_method, method

    # source code
    begin
      sources= nil
      case options[:add].to_s.downcase[0]
        when "a"
          sources= [original_method.to_proc,block]
        else
          sources= [block,original_method.to_proc]
      end
    end

    self.define_singleton_method method do |*arguments|
      sources.each do |proc|
        proc.call_with_binding(original_method.binding?,*arguments)
      end
    end

    return nil
  end
  alias :extend_singleton_method  :inject_singleton_method
  alias :hook_singleton_method    :inject_singleton_method


  # this will inject a code block to a target singleton method
  # by default the before or after sym is not required
  #
  # options can be:
  #  - add: 'before'/'after' add your code into method before the original part of after
  #
  #  Test.inject_instance_method :hello, params: "merged" do |*args|
  #    puts "singleton on a instance method and "+args[0]
  #  end
  #
  def inject_instance_method(method,options={},&block)

    unbound_method= self.instance_method(method).clone

    self.class_eval do
      undef_method method
      define_method(
        method,
        Proc.new { |*args|

          begin
            case options[:add].to_s.downcase[0]
              when "a"
                unbound_method.bind(self).call(*args)
                block.call_with_binding(self.binding?,*args)

              else
                block.call_with_binding(self.binding?,*args)
                unbound_method.bind(self).call(*args)
            end
          end

        }
      )
    end

  end
  alias :extend_instance_method :inject_instance_method
  alias :hook_instance_method   :inject_instance_method

end

Module.__send__ :include, InjectMethods