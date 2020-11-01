require './test/test_helper'

class GameTeamsRepoTest < Minitest::Test
  def setup
    @game_teams_path = './dummy_data/games_dummy.csv'
    @game_teams_repo_test = GameTeamsRepo.new(@games_path)
  end

end  
