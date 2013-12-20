module Kernel

  def sender
    sender_properties= Hash.new
    # File system
    begin
      # folder create from caller
      begin
        folder= caller[0].split(".{rb,ru}:").first.split(File::SEPARATOR)
        sender_properties[:file]= folder[(folder.count-1)].split(':')[0]
        folder= folder[0..(folder.count-2)]
      end
      # after formatting
      begin

        if !File.directory?(folder.join(File::SEPARATOR))
          folder.pop
        end
        folder= File.join(folder.join(File::SEPARATOR))
        if folder != File.expand_path(folder)
          folder= File.expand_path(folder)
        end

      end
      sender_properties[:folder]= folder
    end
    return sender_properties
  end

end