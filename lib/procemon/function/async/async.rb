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

  @@max_retry ||= 6
  def initialize(callable)
    retry_times= nil
    begin
      @thread ||= ::Thread.new { callable.call }
    rescue ThreadError
      retry_times ||=  0
      retry_times  +=  1
      sleep 5
      if retry_times <= @@max_retry
        retry
      else
        @thread ||= callable.call
      end
    end
  end

  def value

    #unless @thread.alive?
    #else
    #  sleep 1
    #end

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