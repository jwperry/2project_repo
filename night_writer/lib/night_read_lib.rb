require './lib/file_reader'
require './lib/braille_key'
require 'pry'

class NightWriter

  def initialize
    @reader = FileReader.new
  end

  # Primary method call, calls method to convert braille input
  # to 3x workable strings, iterates over returned string to
  # check for capitals and capture characters.
  def convert_to_std_eng(string_in)
    output_array = []
    next_capital = false
    until string_in.empty?
      braille_strings = convert_to_three_braille_strings(string_in)
      braille_strings.each do | c |
        character = BRAILLE_KEY.key(c)
        if next_capital == true
          character = character.upcase
        end
        if character == "cap"
          next_capital = true
        else
          next_capital = false
          output_array << character
        end
      end
      output_array << "\n"
    end
    # Removes any "nil" values and calls method to convert to
    # string and print final output to file.
    output_array.compact!
    convert_to_string_and_write(output_array)
  end


  # Grabs all row 1, row 2, and row 3 characters, calls
  # grab_characters to pull in pairs.
  def convert_to_three_braille_strings(string_in)
    in_line1, in_line2, in_line3 = "", "", ""
    in_line1 = grab_line(string_in)
    in_line2 = grab_line(string_in)
    in_line3 = grab_line(string_in)
    return grab_characters(in_line1, in_line2, in_line3)
  end


  # Grab entire line (until \n is hit)
  def grab_line(string_in)
    out_string = ""
    until string_in[0] == "\n"
      out_string.concat(string_in.slice!(0..1))
    end
    string_in.slice!(0)
    return out_string
  end


  # Go through characters in 2s for each line and return string.
  def grab_characters(in_line1, in_line2, in_line3)
    all_lines = []
    (0..in_line1.length).step(2) do | n |
      current_braille_string = ""
      current_braille_string.concat(in_line1.slice(n..n+1))
      current_braille_string.concat(in_line2.slice(n..n+1))
      current_braille_string.concat(in_line3.slice(n..n+1))
      all_lines << current_braille_string
    end
    return all_lines
  end


  # Converts output from array format to string and
  # writes to file.
  def convert_to_string_and_write(output_array)
    final_output = ""
    output_array.each { |n| final_output << n }
    @reader.writes(final_output)
    puts "Created #{ARGV[1]} containing #{final_output.length} characters."
  end
end
