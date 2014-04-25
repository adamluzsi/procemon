Procemon
========

## Gotta catch em all!

With this tool you can hook singleton and instance methods alike in modules and classes


### Examples

Check the "test.rb" in the examples
You need to add plus functionality like logger in the deepness of rack, ease than, and enjoy ruby awesomeness.

The hook code block will act like it's run in the target model/class
params are always have to obey to the original method!
I recommend use "*args" like arguments input, when you need it.
If you dont care about the arguments, dont request it at the code-block


```ruby

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

TestT.test
TestT.new.test "boogie man"

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

```


### After words

With 2.0.0, the project had been cleaned out,
anything else than method hooks moved out.

mpatch:         meta-programing tricks, base class extensions, dsl making helpers

argv:           terminal argument controls,

daemon-ogre:    daemonise trick,

tmp:            tmp folder helpers,

configer:       Applications yaml and json datas in centralized object, based on folder structure logic,

loader:         meta data mounting (best used with configer), dynamic lib reading etc caller based paths
                (require relative directory methods for modules in gems)

Happy Coding! :)