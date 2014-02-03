#encoding: UTF-8
module Procemon

  require 'asynchronous'
  require 'sourcerer'
  require 'loader'

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
    Loader.metaloader_framework root: Loader.caller_root_folder,
                                config_obj: Application.config

    Dir.glob(File.join(Loader.caller_root_folder,"{lib,libs}","*")).each do |path|
      if !File.directory? path
        require path
      end
    end

    # garbage collect
    ObjectSpace.garbage_collect

    # documentation generate
    generate_documentation

    # Daemonize
    Daemon.init

  end


end
