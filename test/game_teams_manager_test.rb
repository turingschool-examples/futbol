require_relative './test_helper'

class GameTeamsManagerTest < Minitest::Test
  def setup
    controller = StatTracker.new
    location = './data/fixture_files/game_teams.csv'
    parent = controller.self
    @game_teams_manager = GameTeamsManager.new(location, parent)
  end
  def test_it_exists	
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  # def test_winningest_coach
  #   assert_equal "Dan Bylsma", @game_teams_manager.winningest_coach(20152016)
  # end
end