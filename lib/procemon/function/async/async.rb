class Async < BasicObject

  def initialize(callable)
    @thread ||= ::Thread.new { callable.call }
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
    value.send(method, *args)
  end

  def respond_to_missing?(method, include_private = false)
    value.respond_to?(method, include_private)
  end

end

#TODO implement paralel syncronizer,
#     so multiple jobs can response as one return array