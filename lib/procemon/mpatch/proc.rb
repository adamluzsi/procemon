class Proc

  # sugar syntax for proc * operator
  #    a = ->(x){x+1}
  #    b = ->(x){x*10}
  #    c = b*a
  #    c.call(1) #=> 20
  def *(other)
    Proc.new { |*args| self[*other[*args]] }
  end unless method_defined? :*

end
