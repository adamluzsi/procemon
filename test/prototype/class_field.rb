class User
  class << self
    attr_reader :fields

    def field (*names)
      names.flatten.each do |name|
        attr_accessor name
        (@fields ||= []) << name
      end
    end
  end

  field :name
  field :age
  field :address
end

user = User.new
user.age     = 22
user.address = "1234"
user.name    = "Me"

#user.class.fields.each do |field|
#  puts user.send(field)
#end

puts user.name