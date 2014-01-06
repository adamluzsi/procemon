Thread.abort_on_exception= true
class Async #< BasicObject

  # remove methods!
  (Async.instance_methods-[
      :undef_method,
      :object_id,
      :__send__,
      :new
  ]).each do |method|
    undef_method method
  end

  def initialize(callable)
    begin
      @rescue_state= nil
      @thread ||= ::Thread.new { callable.call }
      @rescue_state= nil
    rescue ThreadError
      @rescue_state ||= true
      sleep 5
      retry
    end
  end

  def value
    until @rescue_state.nil?
      puts "hahaha"
      sleep 1
    end
    return @thread.value
  end

  def inspect
    if @thread.alive?
      "#<Async running>"
    else
      value.inspect
    end
  end

  def method_missing(method, *args)
    value.__send__(method, *args)
  end

  def respond_to_missing?(method, include_private = false)
    value.respond_to?(method, include_private)
  end

end
