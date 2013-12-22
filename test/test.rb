require_relative "../lib/procemon.rb"
require_relative "lab"

#hello_world!
#puts Dir.pwd.concat(Proc.new{
#  "hy"
#}.source_location[0])

class ProcSource

end


test= Proc.new do |*params|

  puts "teeest"

end

def hello_this sup,yo,lazy=nil,*params

  puts "this is the Body!"

end

#[[:req, :sup], [:opt, :lazy], [:rest, :params]]


#puts method(:hello_world!).source.proc_body
#puts test.source

puts (method(:hello_this).source.parameters.inspect)#.to_proc("params, params2")
