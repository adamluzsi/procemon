# Require Gemfile gems
require_relative "../lib/procemon"


puts( {:hello=> "world",:world => "hello"}.map_hash{|k,v| [ k , 123] })