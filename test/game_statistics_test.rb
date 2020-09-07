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
    @stat = StatTracker.new
  end

  def test_it_exists
    stat_tracker = StatTracker.from_csv(@locations)
    game_statistics = GameStatistics.new(stat_tracker,@stat)

    assert_instance_of GameStatistics, game_statistics
  end

  def test_highest_total_score
    stat_tracker = StatTracker.from_csv(@locations)
    game_statistics = GameStatistics.new(stat_tracker,@stat)
    game_statistics.highest_total_score

    assert_equal 11, @stat.highest_total_score
  end

  def test_lowest_total_score
    stat_tracker = StatTracker.from_csv(@locations)
    game_statistics = GameStatistics.new(stat_tracker,@stat)
    game_statistics.lowest_total_score

    assert_equal 0, @stat.lowest_total_score
  end

  def test_should_return_percentage_of_home_wins
    stat_tracker = StatTracker.from_csv(@locations)
    game_statistics = GameStatistics.new(stat_tracker,@stat)
    game_statistics.percentage_home_wins

    assert_equal 0.44, @stat.percentage_home_wins
  end

  def test_should_return_percentage_of_visitor_wins
    stat_tracker = StatTracker.from_csv(@locations)
    game_statistics = GameStatistics.new(stat_tracker,@stat)
    game_statistics.percentage_visitor_wins

    assert_equal 0.36, @stat.percentage_visitor_wins
  end
end
