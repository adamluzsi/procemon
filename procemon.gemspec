# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__),"files.rb"))

### Specification for the new Gem
Gem::Specification.new do |spec|

  spec.name          = "procemon"
  spec.version       = File.open(File.join(File.dirname(__FILE__),"VERSION")).read.split("\n")[0].chomp.gsub(' ','')
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.description   = %q{This is a collection of my Ruby Procs in the adventure of becoming the best! In short this provides extra tools in Application configs, argumens processing,daemonise,eval, getting source of a block,method,process and work with it, or even fuse them into a new proc , require relative files, or directories, string to duck parsing, system tmp_dir using, meta-programing stuffs,async dsl for easy concurrency patterns in both VM managed and OS managed way (concurrency and Parallelism), micro framework that can be used alongside with any framework and a lot of monkey patch for extra functions :) follow me on github if you like my work! }
  spec.summary       = %q{Gotta catch em all!}
  spec.homepage      = "https://github.com/adamluzsi/procemon"
  spec.license       = "MIT"

  spec.files         = SpecFiles
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  ##=======Runtime-ENV================##
  #spec.add_runtime_dependency "commander", ['~>4.1.3']
  #spec.add_runtime_dependency "activesupport"

  ## Node.JS
  #spec.add_runtime_dependency "execjs"

  ##=======Development-ENV============##
  #spec.add_development_dependency "commander",['~>4.1.3']
  #spec.add_development_dependency "rake"
  #spec.add_development_dependency "bundle"

end
