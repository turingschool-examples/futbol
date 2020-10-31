require_relative './test_helper'

class GameTeamsManagerTest < Minitest::Test
  def setup
    locations = {}
    controller = StatTracker.new(locations)
    location = './data/fixture_files/game_teams.csv'
    @game_teams_manager = GameTeamsManager.get_data(location, controller)
  end

  def test_it_exists	
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_winningest_coach
    assert_equal "Dan Bylsma", @game_teams_manager.winningest_coach(20152016)
  end
end