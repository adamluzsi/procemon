# coding: utf-8

### Get Files from dir
begin

  files_to_be_loaded = %w[version.rb]
  spec_files  = Array.new
  Dir[File.expand_path(File.join(File.dirname(__FILE__),"**","*"))].sort.uniq.each do |one_file_name|
    one_file_name = File.expand_path one_file_name
    file_name = one_file_name[(File.expand_path(File.dirname(__FILE__)).to_s.length+1)..(one_file_name.length-1)]

    if !one_file_name.include?("pkg")
      if !File.directory? file_name
        spec_files.push file_name
        STDOUT.puts file_name if $DEBUG
        if files_to_be_loaded.include? one_file_name.split(File::SEPARATOR).last
          load one_file_name
        end
      end
    end

  end

end

### Specification for the new Gem
Gem::Specification.new do |spec|

  spec.name          = "procemon"
  spec.version       = File.open(File.join(File.dirname(__FILE__),"VERSION")).read.chomp
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.description   = %q{This is a collection of my Ruby Procs in the adventure of becoming the best!}
  spec.summary       = %q{Gotta catch em all!}
  spec.homepage      = "https://github.com/adamluzsi/procemon"
  spec.license       = "MIT"

  spec.files         = spec_files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  ##=======Runtime-ENV================##
  ### Terminal like commands
  #spec.add_runtime_dependency "commander", ['~>4.1.3']

  ## Node.JS
  #spec.add_runtime_dependency "execjs"

  ##=======Development-ENV============##
  #spec.add_development_dependency "commander",['~>4.1.3']
  #spec.add_development_dependency "rake"
  #spec.add_development_dependency "bundle"

end