require File.join 'active_support','time'

class String

  def duck

    begin
      if self == self.to_f.to_s
        return self.to_f
      end
    rescue NoMethodError
    end

    begin
      if self == self.to_i.to_s
        return self.to_i
      end
    rescue NoMethodError
    end

    begin
      if self.gsub(":","") == self.to_datetime.to_s.gsub(
          "T"," ").gsub("+"," +").gsub(":","")
        return self.to_datetime
      end
    rescue Exception
    end

    begin
      if self == self.to_datetime.to_s
        return self.to_datetime
      end
    rescue Exception
    end

    begin
      if self == self.to_date.to_s
        return self.to_date
      end
    rescue Exception
    end

    begin
      if self == "true"
        return true
      end
    rescue NoMethodError
    end


    begin
      if self == "false"
        return false
      end
    rescue NoMethodError
    end

    begin
      string_input= self
      contain= nil
      ["[", "]","^","$","*","/"].each do |one_sym|
        if string_input.include? one_sym
          contain ||= true
        end
      end
      if contain == true
        string_regexp= Regexp.new(string_input).inspect#.gsub('\\','')
        string_regexp= string_regexp[1..(string_regexp.length-2)]
        if string_input == string_regexp
          return Regexp.new(string_input)
        else
          raise ArgumentError,"invalid input string"
        end
      end
    rescue ArgumentError
    end

    begin
      if self == self.to_s.to_s
        return self.to_s
      end
    rescue NoMethodError
    end

  end

  alias :to_duck :duck
  alias :to_d    :duck

end