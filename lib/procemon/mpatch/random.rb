class RND
  class << self
    def string(length= 7,amount=1,hyphen= " ")
      amount_container= Array.new
      amount.times do
        mrg= String.new
        mrg= (0...length).map{ ('a'..'z').to_a[rand(26)] }.join
        amount_container.push mrg
      end
      return amount_container.join(hyphen)
    end
    def integer(length= 3)
      Random.rand(length)
    end
    def boolean
      rand(2) == 1
    end
    def time from = Time.at(1114924812), to = Time.now
      rand(from..to)
    end
    def date from = Time.at(1114924812), to = Time.now
      rand(from..to).to_date
    end
    def datetime from = Time.at(1114924812), to = Time.now
      rand(from..to).to_datetime
    end
  end
end

# alias in Random from RND
begin
  (RND.singleton_methods-Object.singleton_methods).each do |one_method_sym|
    Random.class_eval do
      define_singleton_method one_method_sym do |*args|
        RND.__send__(one_method_sym,*args)
      end
    end
  end
end
