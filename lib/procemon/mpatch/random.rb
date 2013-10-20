class RND
  class << self
    def string(length= 7,amount=1)
      mrg = String.new
      first_string = true
      amount.times do
        a_string = Random.rand(length)
        a_string == 0 ? a_string += 1 : a_string
        mrg_prt  = (0...a_string).map{ ('a'..'z').to_a[rand(26)] }.join
        first_string ? mrg += mrg_prt : mrg+= " " + "#{mrg_prt}"
        first_string = false
      end
      return mrg
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
