require "minitest/autorun"
require "minitest/pride"
require "./lib/modules/seasonable"
require "./lib/stat_tracker"


class SeasonableModuleTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/games.csv'
    team_path = './data/dummy_data/teams.csv'
    game_team_path = './data/dummy_data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_biggest_bust
    assert_equal "Chicago Fire", @stat_tracker.biggest_bust(season_id)
  end

  def test_biggest_surprise
    assert_equal "Houston Dynamo", @stat_tracker.biggest_surprise(season_id)
  end

  def test_winningest_coach
    assert_equal "Alain Vignault", @stat_tracker.winningest_coach(season_id)
  end

  def test_worst_coach
    assert_equal "Craig Berube", @stat_tracker.worst_coach(season_id)
  end

  def test_most_accurate_team
    assert_equal "Houston Dynamo", @stat_tracker.most_accurate_team(season_id)
  end

  def test_least_accurate_team
    assert_equal "Chicago Fire", @stat_tracker.least_accurate_team(season_id)
  end

  def test_most_tackles
    assert_equal "Houston Dynamo", @stat_tracker.most_tackles(season_id)
  end

  def test_fewest_tackles
    assert_equal "Sporting Kansas City", @stat_tracker.fewest_tackles(season_id)
  end
end
