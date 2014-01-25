require_relative "../lib/procemon.rb"

class TestT

  def self.test
    puts self
  end

  def test string
    puts self,string
  end

end

TestT.inject_instance_method :test do |str|

  puts "hello world! instance "+str

end

TestT.inject_singleton_method :test, add: "after" do
  puts "hello world! singleton"
end

#puts "---\nafter,singleton case:"
#TestT.test

puts "---\nbefore,instance case:"
TestT.new.test "boogie man"


#after,singleton case:
#TestT
#hello world! singleton
#
#before,instance case:
#hello world! instance
##<TestT:0x00000000d4a008>