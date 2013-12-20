class Proc

  # sugar syntax for proc * operator
  #    a = ->(x){x+1}
  #    b = ->(x){x*10}
  #    c = b*a
  #    c.call(1) #=> 20
  def *(other)
    Proc.new { |*args| self[*other[*args]] }
  end unless method_defined? :*


  # create a raw eval-able process source, so you can set
  # the right bindings using the .to_proc call from String methods
  @@source_cache= Hash.new
  def source

    # defaults
    begin
      return_string= String.new
      block= 0
    end

    if @@source_cache.keys.include? self.object_id
      return @@source_cache[self.object_id]
    else
      File.open(Dir.pwd.dup.concat(File::Separator).concat(self.source_location[0])
      ).each_line_from self.source_location[1] do |line|

        line.gsub!(/\bdo\b/,'{')
        line.gsub!(/\bend\b/,'}')

        block += line.frequency /{/
        block -= line.frequency /}/

        return_string.concat(line)
        break if block == 0
      end

      return_string.sub!(/^[\w\W]*Proc.new\s*{/,'Proc.new{')
      return_string.sub!(/}[^}]*$/,"}")

      if !return_string.include?('Proc.new')
        return_string.sub!(/^[^{]*(?!={)/,'Proc.new')
      end

      @@source_cache[self.object_id]= return_string

      return return_string
    end

  end

end
