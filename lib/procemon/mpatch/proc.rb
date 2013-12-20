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

    unless @@source_cache[self.object_id].nil?
      return @@source_cache[self.object_id]
    else
      File.open(File.expand_path(self.source_location[0])
      ).each_line_from self.source_location[1] do |line|
        block += line.source_formater_for_line_sub
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
  alias :source_string :source

  def call_with_binding(bind, *args)
    Bindless.new([bind]).run_proc(self, *args)
  end

  def call_with_obj(obj, *args)
    m = nil
    p = self
    Object.class_eval do
      define_method :a_temp_method_name, &p
      m = instance_method :a_temp_method_name; remove_method :a_temp_method_name
    end
    m.bind(obj).call(*args)
  end

end
