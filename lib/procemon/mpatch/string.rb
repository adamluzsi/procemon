class String

  # Find string in othere string
  def positions(oth_string)

    special_chrs=%w[# _ & < > @ $ . , -]+[*(0..9)]+[*("A".."Z")]+[*("a".."z")]
    loop do
      if oth_string.include? special_chrs[0]
        special_chrs.shift
      else
        break
      end
    end

    string=self
    return_array = Array.new
    loop do
      break if string.index(oth_string).nil?
      range_value= ((string.index(oth_string))..(string.index(oth_string)+oth_string.length-1))
      return_array.push range_value
      [*range_value].each do |one_index|
        string[one_index]= special_chrs[0]
      end
    end

    # return value
    return return_array
  end

  # Standard in rails. See official documentation
  # [http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html]
  def camelize(first_letter = :upper)
    if first_letter == :upper
      gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      self[0..0].downcase + camelize[1..-1]
    end
  end unless method_defined? :camelize

  # Standard in rails. See official documentation
  # [http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html]
  def dasherize
    gsub(/_/, '-')
  end unless method_defined? :dasherize

  # Standard in rails. See official documentation
  # [http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html]
  def demodulize
    gsub(/^.*::/, '')
  end unless method_defined? :demodulize

  # Standard in rails. See official documentation
  # [http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html]
  def underscore
    gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
  end unless method_defined? :underscore

  # Check that instance of String is start with an upper case or not
  def capitalized?
    self.match(/^[[:upper:]]/) ? true : false
  end

  # return the number how often the str is with in the self
  # by default with \b regex border
  def frequency(str)
    begin
      if str.class == String
        str= '\b'+str+'\b'
      end
    end
    self.scan(/#{str}/).count
  end

end