require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class GameStatisticsTest < Minitest::Test
  def setup
    game_teams_path = './test/fixtures/game_teams.csv'
    games_path = './test/fixtures/games.csv'
    teams_path = './data/teams.csv'
    locations = {
      games: games_path,
      teams: teams_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end
end
