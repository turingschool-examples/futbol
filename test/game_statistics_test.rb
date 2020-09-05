require './test/test_helper'
require './lib/game_statistics'
require './lib/stat_tracker'

class GameStatisticsTest <Minitest::Test
  def test_it_can_find_highest_total_score
    game_path = './fixtures/fixture_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 7, stat_tracker.highest_total_score
  end
end