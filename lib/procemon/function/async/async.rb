class Async < BasicObject

  @@max_retry_times= 20
  def initialize(callable)
    retry_times= 0
    begin
      @thread ||= ::Thread.new { callable.call }
    rescue ThreadError
      retry_times += 1
      sleep 5
      if retry_times <= @@max_retry_times
        @thread ||= callable.call
      else
        retry
      end
    end
  end

  def value
    @thread.value
  end

  def inspect
    if @thread.alive?
      "#<Future running>"
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

#TODO implement paralel syncronizer,
#     so multiple jobs can response as one return array
# if thread number is overflowed only doing sync job