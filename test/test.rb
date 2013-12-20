require_relative "../lib/procemon.rb"

def test &block

  puts block.source

end



test do
  "hello world!"
end

