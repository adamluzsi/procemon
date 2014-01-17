class Proc

  # create a raw eval-able process source, so you can set
  # the right bindings using the .to_proc call from String methods
  class << self
    attr_accessor :source_cache
  end
  Proc.source_cache= Hash.new
  def source(test=nil)

    # defaults
    begin
      return_string= ProcSource.new
      block= 0
    end

    unless Proc.source_cache[self.source_location].nil?
      return Proc.source_cache[self.source_location]
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

      Proc.source_cache[self.source_location]= return_string

      return return_string
    end
  end
  alias :source_string :source

end