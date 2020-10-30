require './test/test_helper'
require './lib/game_teams'
require './lib/game_teams_manager'

class GameTeamsManagerTest < Minitest::Test
  def setup
    @game_teams_manager = GameTeamsManager.new('./data/game_teams.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_it_can_add_array_of_all_game_team_objects
    assert_instance_of GameTeam, @game_teams_manager.game_teams.first
  end

  def test_total_goals_by_team
    assert_equal 32, @game_teams_manager.total_goals_by_team.keys.size
    assert_equal 1128, @game_teams_manager.total_goals_by_team[28]
    assert_equal 549, @game_teams_manager.total_goals_by_team('away')[28]
    assert_equal 579, @game_teams_manager.total_goals_by_team('home')[28]
  end

  def test_avg_goals_by_team
    assert_equal 32, @game_teams_manager.avg_goals_by_team.keys.size
    assert_equal 2.04, @game_teams_manager.avg_goals_by_team[4]
    assert_equal 2.34, @game_teams_manager.avg_goals_by_team[54]
  end

  # def test_maximum_goals
  #   assert_equal 5, @game_team_manager.team_with_maximum_goals
  # end
  #
  # def test_minimum_goals
  #   assert_equal 0, @game_team_manager.team_with_minimum_goals
  # end

  def test_game_count
    assert_equal 268, @game_teams_manager.game_count(16, 'home')
    assert_equal 266, @game_teams_manager.game_count(16, 'away')
    assert_equal 534, @game_teams_manager.game_count(16)
    assert_equal 102, @game_teams_manager.game_count(54)
  end

  def test_best_offense
    assert_equal 54, @game_teams_manager.best_offense
  end

  def test_worst_offense
    assert_equal 7, @game_teams_manager.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal 6, @game_teams_manager.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal 54, @game_teams_manager.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal 27, @game_teams_manager.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal 7, @game_teams_manager.lowest_scoring_home_team
  end

  def test_it_gives_games_by_season
    assert_equal 806, @game_teams_manager.games_by_season('20122013').size
  end


  def test_winningest_coach
    assert_equal "Claude Julien", @game_teams_manager.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @game_teams_manager.winningest_coach("20142015")
  end
end
