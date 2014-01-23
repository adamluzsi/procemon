module Kernel

  # load meta folders rb files
  def meta_load(target_folder= File.join(Dir.pwd,"lib","**","meta") )

    # find elements
    begin
      Dir.glob( File.join(target_folder,"*.{rb,ru}") ).each do |one_rb_file|
        require one_rb_file
      end
    end

  end

  # mount libs
  def mount_libs(lib_folder=  File.join(Dir.pwd, "lib") )

    # load lib files
    begin
      Dir.glob(File.join(lib_folder,"*.{rb,ru}")).uniq.each do |one_rb_file|
        require one_rb_file
      end
    end

  end
  alias :require_folder :mount_libs

  # Offline repo activate
  def mount_modules(target_folder= File.join(Dir.pwd,"{module,modules}","{gem,gems}") )
    Dir.glob(File.join(target_folder,"**","lib")).select{|f| File.directory?(f)}.each do |one_path|
      $LOAD_PATH.unshift one_path
    end
  end

  # #Return File_name:File_path
  def get_files(folder)

    # Pre def. variables
    begin
      files = Hash.new
    end

    # Validation
    begin
      # Check that does the folder is absolute or not
      if folder != File.expand_path(folder)
        folder =  File.expand_path(folder)
      end
    end

    # Get Files list
    begin
      Dir[File.join(folder,'**','*')].uniq.each do |file_path|
        if !File.directory? file_path
          files[file_path.split(File::SEPARATOR).last.to_sym]= file_path
        end
      end
    end

    # Return file_name:folder
    return files
  end

  # require by absolute path directory's files
  def require_directory(folder)
    Dir.glob(File.join(folder,"**","*.{rb,ru}")).each do |file_path|
      require file_path
    end
  end

  # require sender relative directory's files
  # return the directory and the sub directories file names (rb/ru)
  def require_relative_directory(folder)

    # pre format
    begin

      # path create from caller
      begin
        path= caller[0].split(".{rb,ru}:").first.split(File::SEPARATOR)
        path= path[0..(path.count-2)]
      end

      # after formatting
      begin

        if !File.directory?(path.join(File::SEPARATOR))
          path.pop
        end
        path= File.join(path.join(File::SEPARATOR))
        if path != File.expand_path(path)
          path= File.expand_path(path)
        end

      end

    end

    # find elements
    begin
      return Dir.glob(File.join(path,folder,"**","*.{rb,ru}")).each do |one_path|
        require one_path
      end
    end

  end

end