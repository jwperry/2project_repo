require './lib/file_reader'
require './lib/braille_key'
require 'pry'

class NightWriter

  def initialize
    @reader = FileReader.new
    @final_output_string = ""
    @output_character_count = 0
  end


  # Check to see if a character is capital.
  def is_capital?(char)
    char >= "A" && char <= "Z"
  end


  # Creates one new string, converting string_in to a single
  # linear string of braille.
  def convert_to_braille(string_in)
    converted = ""
    string_in.each_char do |c|
      if is_capital?(c)
        converted = converted.concat(BRAILLE_KEY.fetch("cap"))
        converted.concat(BRAILLE_KEY.fetch(c.downcase))
      else
        converted = converted.concat(BRAILLE_KEY.fetch(c))
      end
    end
    # Call next method.
    break_into_three_strings(converted)
    # Return value for testing.
    return converted
  end


  # Separates converted linear braille string into three separate
  # strings representing the 3 rows of the 2x3 grid
  # of braille characters.
  def break_into_three_strings(converted)
    out_line1, out_line2, out_line3 = "", "", ""
    # Run until string is empty.
    until converted.length == 0
      # If \n, only slice ONE index as it counts as a single char.
      if converted[0]  == "\n"
        out_line1 = out_line1.concat(converted.slice(0))
        out_line2 = out_line2.concat(converted.slice(0))
        out_line3 = out_line3.concat(converted.slice!(0))
      # Slice 2 indices for all other chars as they are all 2x3.
      else
        out_line1 = out_line1.concat(converted.slice!(0..1))
        out_line2 = out_line2.concat(converted.slice!(0..1))
        out_line3 = out_line3.concat(converted.slice!(0..1))
      end
    end
    # Call next method.
    print_braille_to_file(out_line1, out_line2, out_line3)
    # Return value for testing.
    return three_lines = [out_line1, out_line2, out_line3]
  end


  # Calls break_into_three_lines on each string in sequence until
  # last is empty, storing results in @final_output_string, then
  # prints @final_output_string to the output file.
  def print_braille_to_file(out_line1, out_line2, out_line3)
    @final_output_string = ""
    @output_character_count = 0
    until out_line3.empty?
        break_into_three_lines(out_line1)
        break_into_three_lines(out_line2)
        break_into_three_lines(out_line3)
    end
      @reader.writes(@final_output_string)
      puts "Created #{ARGV[1]} containing #{@output_character_count/6} characters."
      # Return value for testing.
      return @final_output_string
    end


    # Moves characters 1-2 at a time into @final_output_string.
    # In combination with loop in print_braille_to_file method,
    # creates 2x3 output pattern.
    def break_into_three_lines(line)
      char_limit_counter = 0
      line.length.times do | n |
        # If \n is hit, break loop as all three lines of output
        # must have \n in the same places.
        if line[0] == "\n"
          @final_output_string.concat(line.slice!(0))
          break
        # If 80 character line limit is reached, break and start
        # a new line.
        elsif char_limit_counter == 80
          @final_output_string.concat("\n")
          break
        # If not full and not \n, add character piece to output.
        else
          @final_output_string.concat(line.slice!(0))
          char_limit_counter += 1
          @output_character_count += 1
          # End and add \n when line is empty to maintain format.
          if line.length == 0 then
            @final_output_string.concat("\n")
            break
          else
          end
        end
      end
    end
end
