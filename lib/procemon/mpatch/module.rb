class Module

  # return the module objects direct sub modules
  def submodules
    constants.collect {|const_name| const_get(const_name)}.select {|const| const.class == Module}
  end

end