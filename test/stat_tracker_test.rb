require './lib/stat_tracker'
require './lib/game'
require './lib/game_teams'
require './lib/game_collection'
require './lib/game_teams_collection'
require 'minitest/autorun'
require 'minitest/pride'

class StatTrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/little_games.csv',
      teams: './data/teams.csv',
      game_teams: './data/little_game_teams.csv'
    }
  end

  def test_it_exists
    stattracker = StatTracker.new(@locations)
    assert_instance_of StatTracker, stattracker
  end

  def test_it_can_load_collections_of_data
    stattracker = StatTracker.new(@locations)
    stattracker.load_game_team_data
    assert_instance_of GameTeamsCollection, stattracker.gtc
    assert_equal GameTeams, stattracker.gtc.game_teams.first.class
  end
end
