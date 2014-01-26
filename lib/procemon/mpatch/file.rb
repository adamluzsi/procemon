class File

  # create a file, if not exsist create file, and dir if needed
  def self.create(route_name ,filemod="w",string_data=String.new)
    begin

      #file_name generate
      if !route_name.to_s.split(File::SEPARATOR).last.nil? || route_name.to_s.split(File::SEPARATOR).last != ''
        file_name = route_name.to_s.split(File::SEPARATOR).last
      else
        file_name = nil?
      end

      #path_way
      begin
        raise ArgumentError, "missing route_name: #{route_name}"   if route_name.nil?
        path = File.expand_path(route_name).to_s.split(File::SEPARATOR)
        path = path - [File.expand_path(route_name).to_s.split(File::SEPARATOR).last]
        path.shift
      end

      #job
      begin
        if !Dir.exists?(File::SEPARATOR+path.join(File::SEPARATOR))

          at_now = File::SEPARATOR
          path.each do |dir_to_be_checked|

            at_now += "#{dir_to_be_checked+File::SEPARATOR}"
            Dir.mkdir(at_now) if !Dir.exists?(at_now)

          end
        end
      end

      # write data
      begin
        full_path = "#{File::SEPARATOR+path.join(File::SEPARATOR)+File::SEPARATOR}#{file_name}"
        if File.exist? full_path
          File.open(full_path,filemod).write string_data
        else
          File.new(full_path,filemod).write string_data
        end
      end

    rescue Exception => ex
      puts ex
    end
  end

  # start read the file object on each line
  # optionable an integer value to start read line at
  # compatible with mac (i am linux user, so not tested)
  def each_line_from(start_at=1,&block)
    unless [Integer,Fixnum,Bignum].include?(start_at.class)
      raise ArgumentError, "invalid line index"
    end
    begin
      line_num= 1
      text= self.read
      text.gsub!(/\r\n?/, "\n")
      text.each_line do |*line|
        if line_num >= start_at
          block.call #*line
        end
        line_num += 1
      end
    end
  end

end