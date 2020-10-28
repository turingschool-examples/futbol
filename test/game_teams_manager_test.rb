require './test/test_helper'
require './lib/game_teams'
require './lib/game_teams_manager'

class GameTeamsManagerTest < Minitest::Test
  def setup
    @game_teams_manager = GameTeamsManager.new('./data/game_teams.csv')
    @game_teams_manager.all
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_it_can_add_array_of_all_game_team_objects
    @game_teams_manager.all
    assert_instance_of GameTeam, @game_teams_manager.game_teams.first
  end

  def test_goals_by_team
    assert_equal Hash, @game_teams_manager.goals_by_team.class
    assert_equal 32, @game_teams_manager.goals_by_team.keys.size
  end

  # def test_maximum_goals
  #   assert_equal 5, @game_team_manager.team_with_maximum_goals
  # end
  #
  # def test_minimum_goals
  #   assert_equal 0, @game_team_manager.team_with_minimum_goals
  # end

  def test_game_count
    assert_equal 102, @game_teams_manager.game_count(54)
  end

  def test_best_offense
    assert_equal 54,
    # assert_equal "Reign FC",
     @game_teams_manager.best_offense
  end
end
