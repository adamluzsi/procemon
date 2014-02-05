class Hash

  # remove elements by keys,
  # array of keys,
  # hashTags,
  # strings
  def trim(*args)

    args.each do |one_element|
      case true

        when one_element.class == Hash
          begin
            one_element.each do |key,value|
              if self[key] == value
                self.delete(key)
              end
            end
          end

        when one_element.class == Array
          begin
            one_element.each do |one_key|
              self.delete(one_key)
            end
          end

        when  one_element.class == Symbol,
            one_element.class == String
          begin
            self.delete(one_element)
          end

      end
    end
    return self

  end

  #pass single or array of keys, which will be removed, returning the remaining hash
  def remove!(*keys)
    keys.each{|key| self.delete(key) }
    self
  end

  #non-destructive version
  def remove(*keys)
    self.dup.remove!(*keys)
  end

  # Returns a new hash with +self+ and +other_hash+ merged recursively.
  #
  #   h1 = {:x => {:y => [4,5,6]}, :z => [7,8,9]}
  #   h2 = {:x => {:y => [7,8,9]}, :z => "xyz"}
  #
  #   h1.deep_merge(h2) #=> { :x => {:y => [7, 8, 9]}, :z => "xyz" }
  #   h2.deep_merge(h1) #=> { :x => {:y => [4, 5, 6]}, :z => [7, 8, 9] }
  def deep_merge(other_hash)
    dup.deep_merge!(other_hash)
  end unless method_defined? :deep_merge

  alias :+ :deep_merge

  # Same as +deep_merge+, but modifies +self+.
  def deep_merge!(other_hash)
    other_hash.each_pair do |k,v|
      tv = self[k]
      self[k] = tv.is_a?(Hash) && v.is_a?(Hash) ? tv.deep_merge(v) : v
    end
    self
  end unless method_defined? :deep_merge!

  # return bool that does the sub hash all element include the hash who call this or not
  def deep_include?(sub_hash)
    sub_hash.keys.all? do |key|
      self.has_key?(key) && if sub_hash[key].is_a?(Hash)
                              self[key].is_a?(Hash) && self[key].deep_include?(sub_hash[key])
                            else
                              self[key] == sub_hash[key]
                            end
    end
  end unless method_defined? :deep_include?

  # map hash will work just alike map but instead of an array it will return a hash obj
  #
  # {:hello=> "world",:world => "hello"}.map_hash{|k,v| [ k , 123] }
  # #> {:hello=>123, :world=>123}
  #
  # {:hello=> "world",:world => "hello"}.map_hash{|k,v| { k => 123 } }
  # #> {:hello=>123, :world=>123}
  #
  def map_hash &block

    tmp_hash= Hash.new
    map_hash_obj= self.map &block
    map_hash_obj.each do |hash|

      if hash.class <= Array
        hash= Hash[*hash]
      end

      tmp_hash.deep_merge!(hash)

    end

    return tmp_hash
  end

end