class Class

  # get singleton methods to target class without super class methods
  def class_methods
    self.methods - Object.methods
  end

  # bind a singleton method to a class object
  def create_class_method(method,&block)
    self.class_eval do
      define_singleton_method method do |*args|
        block.call *args
      end
    end
  end

  # create an instance method
  def create_instance_method(method,&block)
    self.class_eval do
      define_method method do |*args|
        block.call *args
      end
    end
  end

  # Iterates over all subclasses (direct and indirect)
  def each_subclass
    ObjectSpace.each_object(Class) { | candidate |
      begin
        yield candidate if candidate < self
      rescue ArgumentError
        # comparison of Class with Class failed (ArgumentError)
      end
    }
  end

  # Returns an Array of subclasses (direct and indirect)
  def subclasses_all
    ret = []
    each_subclass {|c| ret.push c}
    ret
  end

  alias :all_subclasses :subclasses_all

  # Returns an Array of direct subclasses
  def subclasses
    ret = []
    each_subclass {|c| ret.push(c) if c.superclass == self }
    ret
  end
  alias :subclass :subclasses

  # create singleton attribute
  def class_attr_accessor(name)

    ### GET
    begin
      define_method name do
        class_variable_get "@@#{name}"
      end
    end

    ### SET
    begin
      define_method "#{name}=" do |new_val|
        class_variable_set "@@#{name}", new_val
      end
    end

  end

  # create class instance attribute
  def instance_attr_accessor(name)

    ### GET
    begin
      define_method name do
        instance_variable_get "@#{name}"
      end
    end

    ### SET
    begin
      define_method "#{name}=" do |new_val|
        instance_variable_set "@#{name}", new_val
      end
    end

  end

end