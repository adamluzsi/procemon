require 'yaml'
module YAML
  def self.save_file(file_path,config_hash)
    File.open(file_path, 'w+') {|f| f.write(config_hash.to_yaml) }
  end

  def self.load_file(file_path)
    YAML.load(File.open(file_path))
  end
end

