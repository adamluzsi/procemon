class String

  # this is a helper to create source strings from procs
  def source_formater_for_line_sub
    self.gsub!(';',"\n")
    self.gsub!(/\bdo\b/,'{')
    self.gsub!(/\bend\b/,'}')

    self.frequency(/{/)+
        self.frequency(/def/)-
        self.frequency(/}/)
  end

end