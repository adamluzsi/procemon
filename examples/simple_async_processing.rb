# Require Gemfile gems
require_relative "../lib/procemon"

# you can use simple :c also instead of :concurrency
# remember :concurrency is all about GIL case, so
# you can modify the objects in memory
# This is ideal for little operations in simultaneously or
# when you need to update objects in the memory
calculation = async :concurrency do

  sleep 2
  4 * 2

end
puts "hello concurrency"

calculation.value += 1

puts calculation.value

#>--------------------------------------------------
# or you can use simple {} without sym and this will be by default a
# :concurrency pattern

calculation = async { sleep 3; 4 * 3 }

puts "hello simple concurrency"

calculation.value += 1

# remember you have to use .value to cal the return value from the code block!
puts calculation.value


#>--------------------------------------------------
# now let's see the Parallelism
# you can use simple :p also instead of :parallelism
# remember :parallelism is all about real OS thread case, so
# you CANT modify the objects in memory only copy on write modify
# This is ideal for big operations where you need do a big process
# and only get the return value so you can do big works without the fear of the
# Garbage collector slowness or the GIL lock
# when you need to update objects in the memory use :concurrency
calculation = async :parallelism do

  sleep 4
  4 * 5

end
puts "hello parallelism"

calculation.value += 1

puts calculation.value

#>--------------------------------------------------