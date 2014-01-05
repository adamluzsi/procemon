# Require Gemfile gems
require_relative "../lib/procemon"


calculation = async {

  sleep 10
  4 * 4
}

puts "hello world"

calculation += 1

puts calculation
