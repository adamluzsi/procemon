module Kernel
  def async(&block)
    Async.new(block)
  end
end