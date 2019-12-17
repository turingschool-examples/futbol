require './test_helper'
require_relative '../lib/season'

class SeasonTest < MiniTest::Test
  def method_name
    @season = Season.new(season_id)
  end

  def test_season_is_created_with_id
    assert_instance_of Season, @season
    assert_equal 20122013, @season.id
    assert_equal "Postseason", @season.type
  end
end
