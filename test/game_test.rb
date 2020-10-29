require 'CSV'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/games_repo'
require './lib/game'

class GameTest < Minitest::Test
  def setup

    row = CSV.readlines('./data/games.csv', headers: :true, header_converters: :symbol)[0]
    @parent = mock('game_repo')
    @game1 = Game.new(row, @parent)
  end

  def test_it_exists_and_has_attributes
    assert_equal "2012030221", @game1.game_id
    assert_equal "20122013", @game1.season
    assert_equal "Postseason", @game1.type
    assert_equal 3, @game1.away_team_id
    assert_equal 6, @game1.home_team_id
    assert_equal 2, @game1.away_goals
    assert_equal 3, @game1.home_goals
    assert mock(), @game1.parent
  end

  def test_it_can_report_total_goals
    assert_equal 5, @game1.total_goals
  end
end
