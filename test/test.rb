require_relative "../lib/procemon.rb"


class Test1
end

class Test2 < Test1

end


ret= Array.new
Test1.each_subclass{|c| ret.push c}
puts ret



