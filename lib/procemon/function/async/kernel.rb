module Kernel
  def async(type= :Concurrency ,&block)
    type= type.to_s
    case type.downcase[0]
      when "c"
        begin
          Concurrency.new(block)
        end
      when "p"
        begin
          Parallelism.new(block)
        end
      else
        nil

    end
  end
end
