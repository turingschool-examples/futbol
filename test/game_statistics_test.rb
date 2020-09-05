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
  end

  def test_it_exists
    stat_tracker = StatTracker.new(@locations)
    game_statistics = GameStatistics.new

    assert_instance_of GameStatistics, game_statistics
  end

  def test_highest_total_score
    stat_tracker = StatTracker.new(@locations)
    game_statistics = GameStatistics.new
# require "pry"; binding.pry
    game_statistics.highest_total_score
    # assert_instance_of GameStatistics, game_statistics

    assert_equal 45, game_statistics.highest_total_score
  end

end
