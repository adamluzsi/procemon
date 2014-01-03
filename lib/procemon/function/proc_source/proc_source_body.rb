class ProcSourceBody < String

  def +(oth_str)
    ProcSourceBody.new(self.dup.concat("\n").concat(oth_str.to_s))
  end

  # build proc source
  def build(*params)
    ProcSource.build(self.to_s,*params)
  end

end