#
#class SafeThread < Thread
#
#  undef_method :initialize
#
#end
#
#
#test1 = SafeThread.new { sleep(5); 2*2 }
#
#puts "hello world!"
#
#test2 = SafeThread.new { "hy" }
#
#puts test1.value
