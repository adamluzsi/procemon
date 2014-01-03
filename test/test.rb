# Require Gemfile gems
require 'grape'
require_relative "../lib/procemon"

Grape::API.inject_singleton_method :inherited, add: "after" do |subclass|

  subclass.class_eval do

    before do
      puts "hello world!"
    end

  end

end

puts "hello".binding?