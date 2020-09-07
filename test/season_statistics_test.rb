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
    @stat = StatTracker.new

  end

  def test_it_exists
    stat_tracker = StatTracker.from_csv(@locations)
    season_statistics = SeasonStatistics.new(stat_tracker, @stat)

    assert_instance_of SeasonStatistics, season_statistics
  end

  def test_coach_game_results
    stat_tracker = StatTracker.from_csv(@locations)
    season_statistics = SeasonStatistics.new(stat_tracker, @stat)

    assert_equal 60, season_statistics.coach_game_results.count
  end

  def test_winningest_coach
    stat_tracker = StatTracker.from_csv(@locations)
    season_statistics = SeasonStatistics.new(stat_tracker, @stat)

    assert_equal "Dan Lacroix", season_statistics.winningest_coach
  end

end
