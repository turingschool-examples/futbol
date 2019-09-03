require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'
require 'pry'
require 'csv'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_from_csv
    assert_equal @locations, @stat_tracker
  end

  def test_for_all_made_teams
    require "pry"; binding.pry
    @stat_tracker.shift
    assert_equal 32, @stat_tracker.length
  end

end
