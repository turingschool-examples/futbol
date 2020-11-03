require_relative './test_helper'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    row = {:game_id=>"2012030221",
           :season=>"20122013",
           :type=>"Postseason",
           :date_time=>"5/16/13",
           :away_team_id=>"3",
           :home_team_id=>"6",
           :away_goals=>"2",
           :home_goals=>"3",
           :venue=>"Toyota Stadium",
           :venue_link=>"/api/v1/venues/null"
          }
    @game = Game.new(row)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
    assert_equal "2012030221", @game.game_id
    assert_equal "20122013", @game.season
    assert_equal "3", @game.away_team_id
    assert_equal "6", @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_total_score
    assert_equal 5, @game.total_score
  end

  def test_won_game
    assert_equal false, @game.won_game?("3")
    assert_equal true, @game.won_game?("6")
    assert_equal false, @game.won_game?("7")
  end

  def test_opponent
    assert_equal "6", @game.opponent("3")
    assert_equal "3", @game.opponent("6")
  end

  def test_teams
    assert_equal ["6", "3"], @game.teams
  end

  def test_winner
    assert_equal "home", @game.winner
  end
end
