class Object
  def get_binding
    return binding
  end
end

class Array
  def debug binding
    self.each do |arg|
      puts "arg = #{eval(arg, binding).inspect}"
    end
  end
end