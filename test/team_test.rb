require './test/test_helper'
require './lib/stat_tracker'
require './lib/team_module'

class TeamModuleTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_most_goals_scored
    assert_equal 5, @stat_tracker.most_goals_scored('2')
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored('2')
  end

  def test_favorite_opponent
    assert_equal "Houston Dynamo", @stat_tracker.favorite_opponent('1')
  end

  def test_rival
    assert_equal "Seattle Sounders FC", @stat_tracker.favorite_opponent('3')
  end

end

