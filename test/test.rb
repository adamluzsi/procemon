require_relative "../lib/procemon.rb"

class A

  class << self

    def hello test=nil
      puts "world!"
    end

  end

  def self.singleton test=nil
    puts "singleton"
  end

  def instance          hello= "wolrd"
    puts "instance"
  end

  def self.instance

  end


end

puts A.instance_method(:instance).source

A.class_eval do
  undef_method :instance
end

A.new.instance

puts A.method(:singleton).source


