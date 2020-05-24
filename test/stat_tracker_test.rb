require './test/helper_test'
require './lib/stat_tracker'
require './lib/games'
require './lib/teams'
require './lib/game_teams'

class StatTrackerTest < Minitest::Test

  def test_it_exists
    stat_tracker = StatTracker.from_csv(
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
      })
    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_has_attributes
    stat_tracker = StatTracker.from_csv(
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
      })

      assert_instance_of Games, stat_tracker.games
      assert_instance_of Teams, stat_tracker.teams
      assert_instance_of GameTeams, stat_tracker.game_teams
    end

end
