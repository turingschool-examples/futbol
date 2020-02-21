require './lib/stat_tracker'
require './lib/game_collection'
require './lib/game_teams_collection'
require './lib/game_teams'
require './lib/game'
require './lib/team_collection'
require './lib/team'
require 'minitest/autorun'
require 'minitest/pride'

class StatTrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/little_games.csv',
      teams: './data/teams.csv',
      game_teams: './data/little_game_teams.csv'
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_load_collections_of_game_team_data
    @stat_tracker = StatTracker.from_csv(@locations)
    @stat_tracker.construct_collections
    assert_instance_of GameTeamsCollection, @stat_tracker.gtc
    assert_equal GameTeams, @stat_tracker.gtc.game_teams.first.class
    assert_instance_of GameCollection, @stat_tracker.game_collection
    assert_equal Game, @stat_tracker.game_collection.games.first.class
    assert_instance_of TeamCollection, @stat_tracker.team_collection
    assert_equal Team, @stat_tracker.team_collection.teams.first.class
  end

end
