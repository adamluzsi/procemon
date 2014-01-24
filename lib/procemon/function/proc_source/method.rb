module MethodToProcSource

  # creatue a raw eval-able process source, so you can set
  # the right bindings using the .to_proc call from String methods
  def source

    # defaults
    begin
      return_string= ProcSource.new
      block= 0
    end

    unless ProcSource.source_cache[self.inspect].nil?
      return ProcSource.source_cache[self.inspect]
    else

      if self.source_location.nil?
        return "Proc.new { }"
      end

      File.open(File.expand_path(self.source_location[0])
      ).each_line_from self.source_location[1] do |line|
        block += line.source_formater_for_line_sub
        return_string.concat(line)
        break if block == 0
      end

      begin

        if return_string.split("\n")[0].include? '('
          return_string.sub!('(',' ')
          return_string.sub!(')',' ')
        end

        args_to_replace = return_string.split("\n")[0].match(/\s*def\s*\S*\s*(.*)/).captures[0]

        if args_to_replace != String.new
          return_string.sub!(args_to_replace,"|#{args_to_replace}|")
        end

      rescue TypeError,NilError
      end

      return_string.sub!(/\s*\bdef\s*[\w\S]*/,'Proc.new{')
      return_string.sub!(/}[^}]*$/,"}")

      if !return_string.include?('Proc.new')
        return_string.sub!(/^[^{]*(?!={)/,'Proc.new')
      end

      if !self.source_location.nil?
        ProcSource.source_cache[self.inspect]= return_string
      end

      return return_string
    end
  end

  alias :source_string :source
  alias :proc_source   :source

end

class Method
  include MethodToProcSource
end

class UnboundMethod
  include MethodToProcSource
end