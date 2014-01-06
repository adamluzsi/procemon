# Require Gemfile gems
require_relative "../lib/procemon"


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
puts test1.value == test2.value
puts Time.now-start_time