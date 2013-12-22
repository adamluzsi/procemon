class ProcSourceBody < String

  # build proc source
  def build(*params)
    ProcSource.build(self.to_s,*params)
  end

end