require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/season_statistics'

class SeasonStatisticsTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @season_statistics = SeasonStatistics.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  def test_returning_winningest_coach
    # skip
    season = "20112012"
    assert_equal "Claude Julien", @season_statistics.winningest_coach(season)
  end

  def test_returing_worst_coach
    # skip
    season = "20112012"
    assert_equal "John Tortorella", @season_statistics.worst_coach(season)
  end

  def test_returning_most_accurate_team
    # skip
    season = "20112012"
    assert_equal "FC Dallas", @season_statistics.most_accurate_team(season)
  end

  def test_returning_least_accurate_team
    # skip
    season = "20112012"
    assert_equal "Houston Dynamo", @season_statistics.least_accurate_team(season)
  end

  def test_returning_team_with_most_tackles
    # skip
    season = "20112012"
    assert_equal "Houston Dynamo", @season_statistics.most_tackles(season)
  end

  def test_returning_team_with_least_tackles
    # skip
    season = "20112012"
    assert_equal "FC Dallas", @season_statistics.fewest_tackles(season)
  end

end
