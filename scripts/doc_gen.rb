require_relative "../files.rb"

class Array
  def sum ary
    ary.each do |one_element|
      self.push one_element
    end
    return self
  end
end


DOC_DATA = Hash.new

Dir.glob(File.join(File.dirname(__FILE__),"..","lib","procemon","**","*.{rb,ru}")).uniq.each do |one_file_path|

  comment = Array.new
  comment.push String.new

  File.open(File.expand_path(one_file_path)).read.split("\n").each do |one_line_per_file|

    if one_line_per_file =~ /\W* #/
      comment.push one_line_per_file.gsub(/\W*#/,"#")
    end

    if one_line_per_file =~ /\W*def\W/

      if DOC_DATA[one_file_path.split(File::Separator).last.split('.')[0]].nil?
        DOC_DATA[one_file_path.split(File::Separator).last.split('.')[0]]= Array.new
      end

      DOC_DATA[one_file_path.split(File::Separator).last.split('.')[0]].sum comment

      comment.clear
      comment.push String.new


      DOC_DATA[one_file_path.split(File::Separator).last.split('.')[0]].push one_line_per_file.gsub(/\W*def\W/,"")

    end

  end

end


END_DATA= Array.new
DOC_DATA.each do |key,value|
  END_DATA.push "\n\nin #{key.to_s.capitalize}"
  value.each do |one_element|
    END_DATA.push one_element
  end
end

File.new(File.expand_path(File.join(File.dirname(__FILE__),"test.txt")),"w").write END_DATA.join("\n")