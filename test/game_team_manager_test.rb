require './test/test_helper'

class GameTeamManagerTest < Minitest::Test
  def setup

    @game_team_data = GameTeamManager.new('data/fixture/game_teams_dummy.csv')

  end

  def test_it_exists
    assert_instance_of GameTeamManager, @game_team_data
  end

  def test_make_goals_by_team_hash
    expected = {
      "3"=>[2, 2, 1, 2, 1],

      "6"=>[3, 3, 2, 3, 3]
    }

    assert_equal expected, @game_team_data.make_goals_by_team_hash
  end

  def test_average_goals_by_team_hash
    expected = {
      "3"=>1.6,
      "6"=>2.75
    }

    assert_equal expected, @game_team_data.average_goals_by_team_hash
  end

  def test_teams_max_average_goals
    assert_equal "6", @game_team_data.teams_max_average_goals
  end

  def test_average_team_goals_per_game
    assert_equal 1.6, @game_team_data.average_team_goals_per_game(3)

  def test_it_can_calculate_winningest_coach
    @game_team_data = GameTeamManager.new('data/fixture/game_teams_dummy.csv')

    assert_equal 'Claude Julien', @game_team_data.winningest_coach(20122013)
  end

  def test_it_can_calculate_worst_coach
    @game_team_data = GameTeamManager.new('data/fixture/game_teams_dummy.csv')

    assert_equal 'John Tortorella', @game_team_data.worst_coach(20122013)
  end

  def test_it_can_calculate_most_accurate_team
    @game_team_data = GameTeamManager.new('data/fixture/game_teams_dummy.csv')

    assert_equal 'FC Dallas', @game_team_data.most_accurate_team(20122013)
  end

  def test_it_can_calulate_least_accurate_team
    @game_team_data = GameTeamManager.new('data/fixture/game_teams_dummy.csv')

    assert_equal 'Houston Dynamo', @game_team_data.least_accurate_team
  end

  def test_it_can_calculate_most_tackles
    @game_team_data = GameTeamManager.new('data/fixture/game_teams_dummy.csv')

    assert_equal 'FC Dallas', @game_team_data.most_tackles
  end

  def test_it_can_calculate_fewest_tackles
    @game_team_data = GameTeamManager.new('data/fixture/game_teams_dummy.csv')

    assert_equal 'FC Dallas', @game_team_data.fewest_tackles
  end
end
