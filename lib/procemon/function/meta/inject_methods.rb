class Class

  # this will inject a code block to a target instance method
  # by default the before or after sym is not required
  #
  # options can be:
  #  - params: "merged" -> if given than the block params and the original method params will be merged
  #  - add: 'before'/'after' add your code into method before the original part of after
  #
  #  Test.inject_singleton_method :hello do |*args|
  #    puts "singleton extra, so #{args[0]}"
  #  end
  #
  def inject_singleton_method(method,options={},&block)

    original_method= self.method(method).clone
    #Singleton.methods[self.object_id]= self.method(method)
    self.singleton_class.__send__ :undef_method, method

    proc_source= InjectMethodHelper.generate_source(
        block,original_method,options
    )

    self.define_singleton_method method do |*arguments|
      proc_source.to_proc(self.binding?).call(*arguments)
    end

    return nil
  end
  alias :extend_singleton_method :inject_singleton_method

  # this will inject a code block to a target singleton method
  # by default the before or after sym is not required
  #
  # options can be:
  #  - params: "merged" -> if given than the block params and the original method params will be merged
  #  - add: 'before'/'after' add your code into method before the original part of after
  #
  #  Test.inject_instance_method :hello, params: "merged" do |*args|
  #    puts "singleton on a instance method and "+args[0]
  #  end
  #
  def inject_instance_method(method,options={},&block)

    original_method= self.instance_method(method).clone
    self.class_eval do
      undef_method method
      define_method(
          method,
          InjectMethodHelper.generate_source(
              block,original_method,options
          ).to_proc(self.binding?)
      )
    end

  end

  alias :extend_instance_method :inject_instance_method

end

module InjectMethodHelper

  def self.generate_source block,original_method,options

    # source code
    begin
      source_code= nil
      case options[:add].to_s.downcase[0]
        when "a"
          source_code= original_method.source.body+block.source.body
        else
          source_code= block.source.body+original_method.source.body
      end
    end


    # params
    begin
      source_params= nil
      case options[:params].to_s.downcase[0]
        when "m"
          begin
            source_params= (block.source.params+original_method.source.params)
          end
        else
          begin
            source_params= original_method.source.params
          end
      end
    end

    return source_code.build(*source_params)
  end

end