#encoding: UTF-8
module Procemon

  require File.join(File.dirname(__FILE__),"procemon","function","require")
  require_relative_directory File.join("procemon","function")
  require_relative_directory File.join("procemon","mpatch")

  # load up helpers
  #Dir.glob(\
  #    File.join(\
  #        File.dirname(__FILE__),\
  #        __FILE__.to_s.split(File::Separator).last.split('.')[0],
  #        '**',"*.{rb,ru}"\
  #    )\
  #).uniq.sort.each do |one_helper_file|
  #  load one_helper_file
  #end

  def self.init_all

    # process the ARGV parameters
    process_parameters

    # project name
    set_app_name_by_root_folder

    # init temporarily directory
    tmpdir_init

    # create config singleton
    generate_config

    # load meta-s
    meta_load

    # mount libs
    mount_libs

    # mount offline modules
    mount_modules

    # garbage collect
    ObjectSpace.garbage_collect

    # documentation generate
    generate_documentation(Application.create_documentation)

    # Daemonize
    Daemon.init

  end

  def self.doc_gen
    Dir.glob(File.join(Dir.pwd,'{doc,docs,document,documents}','**','generate_*')).each do |one_doc_generator|
      require one_doc_generator
    end
    puts "done!"
    Process.exit!
  end

  ### Load the requirements in to the general Module
  #load File.expand_path(File.join(File.dirname(__FILE__),'procemon'


end
