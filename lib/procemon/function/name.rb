# set app name
module Procemon
  class << self

    def set_app_name_by_root_folder

      $0= Dir.pwd.to_s.split(File::Separator).last
      Application.name= $0

    end

  end
end