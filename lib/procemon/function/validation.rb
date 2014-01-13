class Object

  # basic validations for those who fear the DUCK!
  def must_be class_name
     if class_name.class == Class
       begin
         if self.class != class_name
          raise ArgumentError, "invalid parameter given: #{self}"
         end
       end
     else
       begin
         if self != class_name
           raise ArgumentError, "invalid parameter given: #{self}"
         end
       end
     end
    return self
  end unless method_defined? :must_be

end
