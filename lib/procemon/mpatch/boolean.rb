class Object

  def boolean?
    !!self == self
  end

  def true?
    self == true
  end

  def false?
    self == false
  end

end