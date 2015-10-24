gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require './lib/night_read_lib'
require 'pry'

class NightWriterTest < Minitest::Test

  def test_that_nightwriter_class_exists
    tester = NightWriter.new
    assert tester
  end





  end








end
