
class Integer

  # because for i in integer/fixnum not working,
  # here is a little patch
  def each &block
    self.times do |number|
      block.call   number
    end
  end

end