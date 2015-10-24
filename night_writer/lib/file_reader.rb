class FileReader

  # Reads in text from source file.
  def read
    filename = ARGV[0]
    File.read(filename)
  end


  # Writes text to file.
  def writes(text)
    output_file = File.open(ARGV[1], 'a')
    output_file.write(text)
  end
end
