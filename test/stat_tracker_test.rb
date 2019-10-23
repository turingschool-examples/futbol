require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def test_it_exists
    game_path = './dummy_data/dummy_games.csv'
    team_path = './dummy_data/dummy_teams.csv'
    game_teams_path = './dummy_data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    assert_instance_of StatTracker, stat_tracker
  end

end
