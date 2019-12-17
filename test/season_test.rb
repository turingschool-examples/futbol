require_relative 'test_helper'
require_relative '../lib/season'

class SeasonTest < MiniTest::Test
  def setup
    @season = Season.new({id: 20122013, path: "./data/games.csv"})
  end

  def test_season_is_created_with_id
    assert_instance_of Season, @season
    assert_equal 20122013, @season.id
  end

  def test_sort_games_in_season_by_game_type
    assert_instance_of Hash, @season.games_by_type
    require "pry"; binding.pry
    assert_equal true, @season.games_by_type["Postseason"].include?(id = 2012030325)
    assert_equal false, @season.games_by_type["Postseason"].include?(2016030171)
    assert_equal false, @season.games_by_type["Postseason"].include?(2012020510)
    assert_equal true, @season.games_by_type["Regular Season"].include?(2012020510)

  end
end
