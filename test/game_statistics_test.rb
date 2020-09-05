require_relative 'test_helper'

class GameStatistcsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @instances = StatTracker.new
  end

  def test_it_exists
    stat_tracker = StatTracker.from_csv(@locations)
    game_statistics = GameStatistics.new

    assert_instance_of GameStatistics, game_statistics
  end

  def test_highest_total_score
    stat_tracker = StatTracker.from_csv(@locations)
    game_statistics = GameStatistics.new
    game_statistics.highest_total_score

    assert_equal 11, game_statistics.stat_tracker_copy.highest_total_score_stat
  end

end
