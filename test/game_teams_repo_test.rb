require './test/test_helper'

class GameTeamsRepoTest < Minitest::Test
  def setup
    @game_teams_path = './dummy_data/game_teams_dummy.csv'
    @game_teams_repo_test = GameTeamsRepo.new(@game_teams_path)
  end

  def test_make_game_teams
    assert_instance_of GameTeams, @game_teams_repo_test.make_game_teams(@game_teams_path)[0]
    assert_instance_of GameTeams, @game_teams_repo_test.make_game_teams(@game_teams_path)[-1]
  end

end  
