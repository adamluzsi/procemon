# Require Gemfile gems
require_relative "../lib/procemon"

calculation = async {

  sleep 10
  4 * 4
}

puts "hello world"

calculation += 1

puts calculation

#>--------------------------------------------------


test1 = async {

  sleep 8
  hello= 14
  sup= "the world is yours"

  sup

}

test2 = async {
  sleep(4)
  "world"
}

start_time= Time.now

asd= test1
puts asd

puts test1.value == test2.value
puts Time.now-start_time