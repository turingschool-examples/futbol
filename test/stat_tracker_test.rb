require_relative 'test_helper'
require_relative '../lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    file_paths = {
                  games: './data/dummy_games.csv',
                  teams: './data/dummy_teams.csv',
                  games_teams: './data/dummy_games_teams.csv'
                }
    @stat_tracker = StatTracker.from_csv(file_paths)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_initializes_with_attributes
    assert_instance_of GamesCollection, @stat_tracker.games
    assert_instance_of TeamsCollection, @stat_tracker.teams
    assert_instance_of GamesTeamsCollection, @stat_tracker.games_teams
  end
end
