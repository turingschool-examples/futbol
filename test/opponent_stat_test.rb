require './test_helper'
require 'minitest/pride'
require_relative '../lib/stat_tracker'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require 'pry'

class OpponentStatTest < Minitest::Test

  def setup
    game_path = './test/test_data/games_sample_2.csv'
    team_path = './test/test_data/teams_sample.csv'
    game_teams_path = './test/test_data/game_teams_sample_2.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end
  def test_opponents
    assert_equal 0, @stat_tracker.opponents("2")["1"]["WINS"].length
    assert_equal 0, @stat_tracker.opponents("2")["1"]["TIES"].length
    assert_equal 1, @stat_tracker.opponents("2")["1"]["LOSS"].length
  end

  def test_head_to_head
    assert_equal ({"FC Dallas"=>0.0, "Seattle Sounders FC"=>1.0}), @stat_tracker.head_to_head("5")
  end

  def test_favorite_opponent
    assert_equal "Toronto FC", @stat_tracker.favorite_opponent("24")
  end

  def test_rival
    assert_equal "Los Angeles FC", @stat_tracker.rival("24")
  end
end
