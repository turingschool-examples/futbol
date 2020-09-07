require_relative 'test_helper'

class SeasonStatistcsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat = StatTracker.from_csv(@locations)

  end

  def test_it_exists
    season_statistics = SeasonStatistics.new(@stat)

    assert_instance_of SeasonStatistics, season_statistics
  end

  def test_coach_game_results
    season_statistics = SeasonStatistics.new(@stat)

    assert_equal 60, season_statistics.coach_game_results.count
    assert_equal 60, season_statistics.coach_game_results.count
  end

  def test_winningest_coach
    season_statistics = SeasonStatistics.new(@stat)

    assert_equal "Claude Julien", season_statistics.winningest_coach("20132014")
    assert_equal "Alain Vigneault", season_statistics.winningest_coach("20142015")
  end

end
