class Object

  # The hidden singleton lurks behind everyone
  def metaclass; class << self; self; end; end

  # extend the metaclass with an instance eval
  def meta_eval &blk; metaclass.instance_eval &blk; end

  # Adds methods to a metaclass
  def meta_def name, &blk
    meta_eval { define_method name, &blk }
  end

  # Defines an instance method within a class
  def class_def name, &blk
    class_eval { define_method name, &blk }
  end

  # constantize object
  def constantize
    camel_cased_word= self.to_s
    names = camel_cased_word.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name, false) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end unless method_defined? :constantize

  # find and replace object in object
  def find_and_replace(input,*params)
    params=Hash[*params]
    # some default values
    begin
      #None!
    end
    # Do the find and replace
    begin

      if    input.class == Array
        input.count.times do |counter|
          params.each do |key,value|
            input[counter]= input[counter].gsub(key,value)
          end
        end
      elsif input.class == String
        params.each do |key,value|
          input= input.gsub(key,value)
        end
      elsif input.class == Integer
        params.each do |key,value|
          input= input.to_s.gsub(key,value).to_i
        end
      elsif input.class == Float
        params.each do |key,value|
          input= input.to_s.gsub(key,value).to_f
        end
      end

      # return value
      return input
    end
  end

  # each for any object
  def each_universal(&block)
    case self.class.to_s.downcase
      when "hash"
        self.each do |key,value|
          block.call(key,value)
        end
      when "array"
        self.each do |one_element|
          block.call(self.index(one_element),one_element)
        end
      else
        block.call nil,self
    end
  end

  # map an object => experiment
  def map_object(symbol_key="$type")

    stage       = self
    do_later    = Hash.new
    samples     = Hash.new
    relations   = Hash.new
    main_object = nil

    loop do

      # processing
      begin

        tmp_key = String.new
        tmp_hash= Hash.new
        stage.each_universal do |key,value|

          if value.class.to_s.downcase == "string"

            if key== symbol_key
              tmp_key= value
              main_object ||= value
            else
              tmp_hash[key]= value
            end

          else

            value.each_universal do |key_sub,value_sub|
              if key_sub == symbol_key && tmp_key != String.new
                child_property = Hash.new
                child_property['type']= value_sub
                child_property['class']= value.class.to_s
                relations[tmp_key]= child_property
              end
              do_later[key_sub]= value_sub
            end

          end
        end

        if tmp_key != String.new && tmp_hash != Hash.new
          samples[tmp_key]=tmp_hash
        end

      end

      # finish
      begin
        break if do_later == Hash.new
        stage= do_later
        do_later = Hash.new
      end

    end

    return {:samples    => samples,
            :relations  => relations,
            :main       => main_object
    }

  end

  # is class?
  def class?
    self.class == Class
  end

  # convert class instance instance variables into a hash object
  def convert_to_hash

    unless self.class.class == Class
      raise NoMethodError, "undefined method `to_hash' for #{self.inspect}"
    end

    tmp_hash= Hash.new()
    self.instance_variables.each do|var|
      tmp_hash[var.to_s.delete("@")] = self.instance_variable_get(var)
    end

    return tmp_hash

  end

  alias :map_sample :map_object
  alias :each_univ :each_universal
  alias :fnr :find_and_replace

end