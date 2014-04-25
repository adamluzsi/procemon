# coding: utf-8

Gem::Specification.new do |spec|

  spec.name          = "procemon"
  spec.version       = File.open(File.join(File.dirname(__FILE__),"VERSION")).read.split("\n")[0].chomp.gsub(' ','')
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.description   = %q{ Lasso for Methods! You can hook up processes before and after to existing method objects, it's like a monkey patch without have to open up the actually method. }
  spec.summary       = %q{ Gotta catch em all! }
  spec.homepage      = "https://github.com/adamluzsi/procemon"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "loader",">= 1.2.3"
  spec.add_dependency "mpatch"
  spec.add_dependency "bindless"

end
