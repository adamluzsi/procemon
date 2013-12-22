class ProcSourceParams < Array

  # merge two proc params obj
  # if multiple rest obj found
  # it will remove and make an *args obj as last element
  # if they are not equal ,
  # else it makes it the last element only
  def +(oth_ary)

    merged_array= (Array[*self]+Array[*oth_ary])

    rest_state= nil
    rest_elements= Array.new
    merged_array.dup.each do |element|
      if element.include? '*'
        merged_array.delete(element)
        rest_state ||= true
        rest_elements.push(element)
      end
    end

    rest_elements.uniq!
    if rest_elements.count == 1 && !rest_elements.empty?
      merged_array.push(rest_elements[0])
      rest_state= nil
    end

    unless rest_state.nil?
      merged_array.push('*args')
    end

    return ProcSourceParams[*merged_array]
  end

end