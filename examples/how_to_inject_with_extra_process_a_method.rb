require 'procemon'

class TestT

  def self.test
    puts self
  end

  def test
    puts self
  end

end

TestT.inject_instance_method :test do

  puts "hello world! instance"

end

TestT.inject_singleton_method :test, :after do

  puts "hello world! singleton"

end

TestT.test
TestT.new.test

#> TestT
#> hello world! singleton
#> hello world! instance
#> #<TestT:0x0000000288b808>

