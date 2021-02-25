require "./test/test_helper"

class GameTeamManagerTest < Minitest::Test
  def setup
    @game_team_data = './data/game_teams_to_test.csv'

    # @game_team_manager = GameTeamManager.new(CSV.parse(File.read("./data/games_to_test.csv"), headers: true))
    @game_team_manager = GameTeamManager.new(@game_team_data)
  end

  def test_it_exists
    assert_instance_of GameTeamManager, @game_team_manager
  end
end 
