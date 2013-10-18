def putsf(integer,*args)
  command_string=String.new
  args.each do |one_element|
    command_string+="%-#{integer}s"
  end
  command_string+="\n"
  printf command_string,*args
end

