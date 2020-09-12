require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_teams_manager'
require './lib/game_team'
require 'pry';
require 'mocha/minitest'

class GameTeamsManagerTest < Minitest::Test
  def setup
    tracker = mock('stat_tracker')
    game_teams_path = './data/dummy_game_teams.csv'
    @game_teams_manager = GameTeamsManager.new(game_teams_path, tracker)
  end

  def test_it_exists
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_average_number_of_goals_scored_by_team
    assert_equal 2.0, @game_teams_manager.average_number_of_goals_scored_by_team('6')
  end
end
