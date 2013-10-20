class Array

  # remove arguments or array of
  # parameters from the main array
  def trim(*args)

    args.dup.each do |one_element|
      if one_element.class == Array
        args.delete_at(args.index(one_element))
        args= args+one_element
      end
    end

    delete_array= Array.new
    args.each do |one_element|
      index= self.index(one_element)
      unless index.nil?
        delete_array.push index
        self.delete_at(index)
      end
    end

    return self

  end

  # return index of the target element
  def index_of(target_element)
    array = self
    hash = Hash[array.map.with_index.to_a]
    return hash[target_element]
  end

  # remove n. element from the end
  # and return a new object
  def pinch n=1
    return self[0..(self.count-(n+1))]
  end

  # remove n. element from the end
  # and return the original object
  def pinch! n=1
    n.times do
      self.pop
    end
    return self
  end

  # return boolean by other array
  # all element included or
  # not in the target array
  def contain?(oth_array)#anothere array
    (oth_array & self) == oth_array
  end

  # do safe transpose
  def safe_transpose
    result = []
    max_size = self.max { |a,b| a.size <=> b.size }.size
    max_size.times do |i|
      result[i] = Array.new(self.first.size)
      self.each_with_index { |r,j| result[i][j] = r[i] }
    end
    result
  end

  alias :contains? :contain?
end