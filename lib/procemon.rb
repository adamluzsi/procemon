#encoding: UTF-8
module Procemon

  require 'asynchronous'
  require File.join(File.dirname(__FILE__),"procemon","function","require")
  require_relative_directory File.join("procemon","mpatch")
  require_relative_directory File.join("procemon","function")

  def self.init_all

    # process the ARGV parameters
    process_parameters

    # project name
    set_app_name_by_root_folder

    # init temporarily directory
    tmpdir_init

    # create config singleton
    metaloader_framework

    # load meta-s
    meta_load

    # mount libs
    mount_libs

    # mount offline modules
    mount_modules

    # garbage collect
    ObjectSpace.garbage_collect

    # documentation generate
    generate_documentation

    # Daemonize
    Daemon.init

  end


end
