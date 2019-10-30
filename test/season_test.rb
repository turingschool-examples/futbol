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
    assert_equal "Atlanta United", @stat_tracker.biggest_bust('20132014')
  end

  def test_biggest_surprise
    assert_equal "Seattle Sounders FC", @stat_tracker.biggest_surprise('20132014')
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
    assert_equal 'Houston Dynamo', @stat_tracker.most_tackles('20132014')
  end

  def test_fewest_tackles
    assert_equal 'Atlanta United', @stat_tracker.fewest_tackles('20132014')
  end

end
