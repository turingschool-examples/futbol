require_relative 'test_helper'
require_relative '../lib/season'

class SeasonTest < MiniTest::Test
  def setup
    @season = Season.new({id: 20122013, path: "./data/games.csv"})
  end

  def test_season_is_created_with_id
    assert_instance_of Season, @season
    assert_equal 20122013, @season.id
    # assert_equal "Postseason", @season.type
  end

  def test_get_total_games_in_season_by_season_type
    assert_instance_of Hash, @season.games_in_season
    assert_equal true, @season.games_in_season["Postseason"].include?(2012030325)
    assert_equal false, @season.games_in_season["Postseason"].include?(2016030171)
    assert_equal false, @season.games_in_season["Postseason"].include?(2012020510)
    assert_equal true, @season.games_in_season["Regular Season"].include?(2012020510)
  end
end
