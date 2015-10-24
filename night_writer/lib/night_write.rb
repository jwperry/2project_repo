require './lib/night_write_lib'
require './lib/file_reader'

file = File.open(ARGV[1], 'w')

handle = FileReader.new

night_writer = NightWriter.new

night_writer.convert_to_braille(handle.read)

file.close
