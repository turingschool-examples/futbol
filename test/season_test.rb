require './test/test_helper'
require './lib/stat_tracker'
require './lib/season_module'

class SeasonModuleTest < Minitest::Test

  def setup
    game_path = './data/games_fixture_2.csv'
    team_path = './data/teams_fixture_2.csv'
    game_teams_path = './data/game_teams_fixture_2.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_biggest_bust
    assert_equal "Houston Dynamo", @stat_tracker.biggest_bust('20122013')
  end

  def test_biggest_surprise
    assert_equal "Chicago Fire", @stat_tracker.biggest_surprise('20122013')
  end

  def test_winningest_coach
  end

  def test_worst_coach
  end

  def test_most_accurate_team
  end

  def test_least_accurate_team
  end

  def test_most_tackles
  end

  def test_fewest_tackles
  end

end
