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

  # return boolean by other array
  # if any element included from
  # the oth_array, return a true
  def contain_any_of?(oth_array)
    oth_array.each do |element|
      if self.include? element
        return true
      end
    end
    return false
  end

  alias :contains_any_of? :contain_any_of?
  alias :has_any_of? :contain_any_of?

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

  # return boolean
  # if any element class is equal to th given class
  # return a true , else false
  def contain_element_of_class?(class_name)
    target_array= self.map{|e| e.class }.uniq
    if class_name.class != Class
      raise ArgumentError, "Argument must be a Class!"
    end
    if target_array.include? class_name
      return true
    end
    return false
  end

  alias :contains_element_of_class? :contain_element_of_class?
  alias :has_element_of_class?      :contain_element_of_class?

  # generate params structure from array
  # *args => [:opts,:args]
  def params_separation

    options= self.map { |element|
      if element.class == Hash
        element
      end
    }.uniq - [ nil ]
    #options.each{|e| self.delete(e) }
    arguments= self.dup - options
    options= Hash[*options]

    return [options,arguments]

  end

  alias :separate_params :params_separation
  alias :process_params  :params_separation

  # generate params structure from array
  # return_array
  def extract_class! class_name

    if class_name.class != Class
      raise ArgumentError, "parameter must be a class name"
    end

    return_value= self.map { |element|
      if element.class == class_name
        element
      end
    }.uniq - [ nil ]
    return_value.each{|e| self.delete(e) }

    return return_value

  end
  alias :cut_class! :extract_class!

  # generate params structure from array
  # *args - options {}
  def extract_options!
    options= self.extract_class! Hash
    return Hash[*options]
  end
  alias :extract_hash! :extract_options!

end