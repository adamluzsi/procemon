class Module

  # return the module objects direct sub modules
  def modules
    constants.collect {|const_name| const_get(const_name)}.select {|const| const.class == Module}
  end

  # return the module objects direct sub modules
  def classes
    constants.collect {|const_name| const_get(const_name)}.select {|const| const.class == Class}
  end

  alias :submodules :modules
  alias :subclasses :classes

end