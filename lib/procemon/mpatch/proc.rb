class Proc

  # sugar syntax for proc * operator
  #    a = ->(x){x+1}
  #    b = ->(x){x*10}
  #    c = b*a
  #    c.call(1) #=> 20
  def *(other)
    Proc.new { |*args| self[*other[*args]] }
  end unless method_defined? :*

  def call_with_binding(bind, *args)
    Bindless.new([bind]).run_proc(self, *args)
  end

  def call_with_obj(obj, *args)
    m = nil
    p = self
    Object.class_eval do
      define_method :a_temp_method_name, &p
      m = instance_method :a_temp_method_name
      remove_method :a_temp_method_name
    end
    m.bind(obj).call(*args)
  end

end
