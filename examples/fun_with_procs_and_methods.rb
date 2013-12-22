require_relative "../lib/procemon.rb"



test= Proc.new do |*params|

  puts "some awsome code here"

end

def hello_this sup,yo,lazy=nil

  puts "this is the Body!"

end


method_source= method(:hello_this).source
#Proc.new{ |sup,yo,lazy=nil,*params|
#
#  puts "this is the Body!"
#
#}


proc_source= test.source
#Proc.new{ |*params|
#
#  puts "some awsome code here"
#
#}

# example for terminal run
#puts method_source
#puts method_source.body,"---------"
#puts method_source.params,"---------"
#puts method_source.parameters.inspect,"---------"
#puts method_source.params.inspect,"---------"

merged_proc= ( method_source.body + proc_source.body ).build(*(method_source.params+proc_source.params))
puts merged_proc


