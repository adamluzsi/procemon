require "procemon"

class TestT

  def self.test
    puts self
  end

  def test string
    puts self,string
  end

end

TestT.hook_instance_method :test do |*args|
  puts "before hook and str: " + args[0].to_s.inspect
end

TestT.hook_singleton_method :test, add: "after" do

  puts "after hook for singleton"

end

puts "\n\n",
     "after,singleton case:",
     "---------------------"
TestT.test

puts "\n\n",
     "before,instance case:",
     "---------------------"
TestT.new.test "boogie man"

puts "\n"


# after,singleton case:
# ---------------------
# TestT
# after hook for singleton
#
#
# before,instance case:
# ---------------------
# before hook and str: "boogie man"
# #<TestT:0x000000027bebc8>
# boogie man
