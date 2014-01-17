class ProcSource < String

  class << self
    attr_accessor :source_cache
    attr_accessor :eval_keys
  end
  self.source_cache= Hash.new
  self.eval_keys= Array.new


  def self.build(source_code_to_be_wrappered,*params_obj_array)
    self.new(source_code_to_be_wrappered).wrapper_around!(*params_obj_array)
  end

  def wrapper_around!(*params)
    if !params.nil?
      params= params.join(',')
      params.prepend(' |')
      params.concat('|')
    end
    self.prepend("Proc.new{#{params}\n")
    self.concat("\n}")
  end

  # create process object from valid process string
  def to_proc(binding=nil)
    begin

      unless self.split("\n")[0].include?('Proc.new')
        raise ArgumentError, "string obj is not a valid process source"
      end

      return_proc= nil
      if binding.nil?
        return_proc= eval(self)
      else
        return_proc= eval(self,binding)
      end

      if ProcSource.eval_keys.count > 100
        ProcSource.eval_keys.each {|e| ProcSource.source_cache.delete(e) }
        ProcSource.eval_keys.clear
      end
      ProcSource.source_cache[return_proc.inspect]= self
      ProcSource.eval_keys.push return_proc.inspect

      return return_proc
    end
  end

  def body

    body= ProcSourceBody.new(self.dup.to_s)
    body.sub!(/.*Proc\.new *{ *(\|.*\|)?/,String.new)
    body.gsub!(/^$\n/, String.new)
    body.sub!(/\s*}\s*$/,String.new)

    return body
  end

  def params
    #SystemStackError
    params= self.dup
    params.sub!(params.split("\n")[0].scan(/\s*Proc.new\s*{/)[0],String.new)
    params.sub!(' ','')
    params= params.split("\n")[0].scan(/^\s*{?\s*(.*)/)[0][0].gsub!('|','')
    if params.nil?
      return nil
    end
    return ProcSourceParams[*params.split(',')]
  end

  def parameters

    return_array= Array.new
    params= self.params
    params.each do |one_raw_parameter|
      case true
        when one_raw_parameter.include?('=')
          begin
            return_array.push Array.new.push(:opt).push(
                                  one_raw_parameter.split('=')[0].to_sym)
          end
        when one_raw_parameter[0] == '*'
          begin
            one_raw_parameter[0]= ''
            return_array.push Array.new.push(:rest).push(
                                  one_raw_parameter.to_sym)
          end
        else
          begin
            return_array.push Array.new.push(:req).push(
                                  one_raw_parameter.to_sym)
          end
      end
    end

    return return_array
  end

end