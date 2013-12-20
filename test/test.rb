require_relative "../lib/procemon.rb"
require_relative "lab"

#hello_world!
#puts Dir.pwd.concat(Proc.new{
#  "hy"
#}.source_location[0])

puts method(:hello_world!).source


