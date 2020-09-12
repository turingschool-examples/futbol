require './test/test_helper'
require './lib/game_teams_methods'

class GameTeamsMethodsTest < Minitest::Test

  def test_it_exists
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_instance_of GameTeamsMethods, game_teams_methods

    assert_equal './data/game_teams.csv', game_teams_methods.game_teams
  end

  def test_it_can_generate_array_of_game_teams_objects
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_instance_of Array, game_teams_methods.create_array(game_teams)
    assert_instance_of GameTeams, game_teams_methods.all_game_teams[0]
    assert_instance_of GameTeams, game_teams_methods.all_game_teams[999]
  end

  def test_it_can_return_best_offense_team
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_equal "54", game_teams_methods.best_offense_team
  end

  def test_it_will_make_a_hash_of_team_id_and_goal_array
    game_teams = './data/game_teams.csv'

    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_instance_of Hash, game_teams_methods.assign_goals_by_teams
    assert_equal true, game_teams_methods.assign_goals_by_teams.keys.include?("3")
    assert_equal true, game_teams_methods.assign_goals_by_teams.keys.include?("6")
  end

  def test_it_can_return_a_hash_of_teams_and_average_goal
    game_teams = './data/game_teams.csv'

    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_instance_of Hash, game_teams_methods.average_goals_by_team
  end

  def test_it_can_return_worst_offense_team
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_equal "7", game_teams_methods.worst_offense_team
  end

  def test_it_can_get_highest_scoring_visitor_team
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_equal "6", game_teams_methods.highest_scoring_team("away")
  end

  def test_it_can_get_highest_scoring_home_team
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_equal "54", game_teams_methods.highest_scoring_team("home")
  end

  def test_it_can_get_lowest_scoring_visitor_team
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_equal "27", game_teams_methods.lowest_scoring_team("away")
  end

  def test_it_can_get_lowest_scoring_home_team
    game_teams = './data/game_teams.csv'
    game_teams_methods = GameTeamsMethods.new(game_teams)

    assert_equal "7", game_teams_methods.lowest_scoring_team("home")
  end
end
