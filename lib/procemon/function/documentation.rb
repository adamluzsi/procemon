class String



  def find_doc_part(oth_str)
    self.each_line do |target_line|
      puts target_line[0..(oth_str.length-1)]
      if target_line[0..(oth_str.length-1)] == oth_str
        return target_line[(oth_str.length)..(target_line.length)]
      end
    end
  end

end