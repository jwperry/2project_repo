gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require './lib/night_write_lib'
require 'pry'

class NightWriterTest < Minitest::Test

  def test_that_nightwriter_class_exists
    tester = NightWriter.new
    assert tester
  end

  def test_converts_lowercase_to_braille
    tester = NightWriter.new
    assert_equal "0.....0.0...00....", tester.convert_to_braille("abc")
  end

  def test_converts_uppercase_to_braille
    tester = NightWriter.new
    assert_equal ".....000.0.......00..0.......0000...", tester.convert_to_braille("DEF")
  end

  def test_converts_upper_and_lower_to_braille
    tester = NightWriter.new
    assert_equal "0000.......00.00...00........0.000..", tester.convert_to_braille("gHiJ")
  end

  def test_converts_to_braille_with_spaces
    tester = NightWriter.new
    assert_equal "0...0.......0.0.0.......00..0.", tester.convert_to_braille("k l m")
  end

  def test_converts_to_braille_with_new_lines
    tester = NightWriter.new
    assert_equal "00.00.\n0..00.\n000.0.", tester.convert_to_braille("n\no\np")
  end

  def test_converts_to_braille_with_punctuation
    tester = NightWriter.new
    assert_equal "00000...000.0.000...0.00.00.0.....00", tester.convert_to_braille("q!r?s-")
  end

  def test_identifies_uppercase
    tester = NightWriter.new
    assert tester.is_capital?("A")
  end

  def test_identifies_lowercase
    tester = NightWriter.new
    refute tester.is_capital?("b")
  end

  def test_classifies_non_a_through_z_as_not_capital
    tester = NightWriter.new
    refute tester.is_capital?("!")
    refute tester.is_capital?(" ")
    refute tester.is_capital?("\n")
    refute tester.is_capital?(",")
    refute tester.is_capital?("-")
  end
end
