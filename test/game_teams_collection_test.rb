require_relative './test_helper'
require './lib/game_teams_collection'
require './lib/team'
require './lib/stat_tracker'


class GameTeamsCollectionTest < Minitest::Test

  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stattracker = StatTracker.from_csv(locations)
    @gameteamcollection = @stattracker.game_teams
  end

  def test_it_exists

    assert_instance_of GameTeamsCollection, @gameteamcollection
  end

  def test_first_game
    assert_instance_of GameTeam, @gameteamcollection.game_teams[0]
  end

  def test_find_by_id

    assert_equal "20122013", @gameteamcollection.find_by_id("2012030221")
  end

  def test_all_games

    assert_equal 10, @gameteamcollection.game_teams.length
  end

  def test_games_by_team

    expected = {"3"=>5, "6"=>5}
    assert_equal expected, @gameteamcollection.games_by_team
  end

  def test_away_games_by_team

    expected = {"3"=>3, "6"=>2}
    assert_equal expected, @gameteamcollection.away_games_by_team
  end

  def test_home_games_by_team

    expected = {"6"=>3, "3"=>2}
    assert_equal expected, @gameteamcollection.home_games_by_team
  end

  def test_average_goals_by_team

    expected = {"3"=>1.6, "6"=>2.8}
    assert_equal expected, @gameteamcollection.average_goals_by_team
  end

  def test_average_away_goals_by_team

    expected = {"3"=>1.67, "6"=>2.5}
    assert_equal expected, @gameteamcollection.average_away_goals_by_team
  end

  def test_average_home_goals_by_team

    expected ={"6"=>3.0, "3"=>1.5}
    assert_equal expected, @gameteamcollection.average_home_goals_by_team
  end

  def test_best_offense

    assert_equal "FC Dallas", @gameteamcollection.best_offense
  end

  def test_worst_offense
    assert_equal "Houston Dynamo", @gameteamcollection.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @gameteamcollection.highest_scoring_visitor
  end

  def test_highest_scoring_hometeam

    assert_equal "FC Dallas", @gameteamcollection.highest_scoring_hometeam
  end

  def test_lowest_scoring_visitor

    assert_equal "Houston Dynamo", @gameteamcollection.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team

    assert_equal "Houston Dynamo", @gameteamcollection.lowest_scoring_hometeam
  end
end
