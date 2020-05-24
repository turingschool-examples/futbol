require './test/helper_test'
require './lib/stat_tracker'

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



end
