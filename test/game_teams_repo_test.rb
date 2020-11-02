require './test/test_helper'

class GameTeamsRepoTest < Minitest::Test
  def setup
    @game_teams_path = './data/game_teams.csv'
    @game_teams_repo_test = GameTeamsRepo.new(@game_teams_path, stat_tracker)
    @teams_path = './data/teams.csv'
    @teams = TeamsRepo.new(@teams_path)
  end

  def test_make_game_teams
    assert_instance_of GameTeams, @game_teams_repo_test.make_game_teams(@game_teams_path)[0]
    assert_instance_of GameTeams, @game_teams_repo_test.make_game_teams(@game_teams_path)[-1]
  end

  def test_best_offense
    assert_equal "54", @game_teams_repo_test.best_offense
  end

  def test_worst_offense
    assert_equal "7", @game_teams_repo_test.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "6", @game_teams_repo_test.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "54", @game_teams_repo_test.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "27", @game_teams_repo_test.lowest_scoring_visitor
  end

  def test_lowest_scoring_home
    assert_equal "7", @game_teams_repo_test.lowest_scoring_home_team
  end

end  
