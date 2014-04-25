#encoding: UTF-8
module Procemon

  require 'bindless'
  require 'loader'

  require 'mpatch/object'
  MPatch.patch!

  require_relative_directory "procemon"

end
