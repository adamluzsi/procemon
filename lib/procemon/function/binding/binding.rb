class Object

  def binding?
    return binding
  end

  alias :get_binding :binding?

end

class Array
  def debug binding
    self.each do |arg|
      puts "arg = #{eval(arg, binding).inspect}"
    end
  end
end