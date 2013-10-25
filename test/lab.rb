require "procemon"


#class Hello
#
#  def world arg
#    puts arg
#  end
#
#  def hello
#    puts "this is hello, hy!"
#  end
#
#end
#
#class Proc
#
#  def source_code
#    puts self.source_location.inspect
#
#  end
#
#end
#
#
#
##.to_proc.source_code
#TestProc= Proc.new do
#  puts "hello world!"
#end
#
#SecurityProc = Proc.new{ |*args|
#  puts "hello world!"
#}
#
#class Test
#
#
#  attr_accessor :test1
#  Test= Proc.new do
#    puts "hello world"
#  end
#
#  class << self
#    attr_accessor :test2
#  end
#
#  def hello *args
#    puts self.test1.inspect
#  end
#
#  def self.hello *args
#    puts self.test2.inspect
#  end
#
#  def security_proc *args
#    self.class::Test.call *args
#  end
#
#
#end
#
##test= Test.new
##test.security_proc
#
##require "sourcify"
##require "debugger"
##debugger
#
#puts SecurityProc.source_location.inspect
#puts Test.method(:hello).to_proc.source_location.inspect
#puts TestProc.source_location.inspect






#method(:world).get_binding

#puts test.get_binding
#puts test.get_binding2
#puts test.get_binding
