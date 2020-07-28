require "minitest/autorun"
require "minitest/pride"
require "./lib/futbol_data"

class FutbolDataTest < Minitest::Test

  def test_create_chosen_data_set
    futbol = FutbolData.new("team")
    assert_equal "", futbol.create_objects  
  end

end
