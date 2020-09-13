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

  def test_return_games_played_by_team
    assert_equal 6, @game_teams_manager.games_played('6').count
  end

  def test_return_total_goals_by_team
    assert_equal 15, @game_teams_manager.total_goals('6')
  end

  def test_average_number_of_goals_scored_by_team
    assert_equal 2.5, @game_teams_manager.average_number_of_goals_scored_by_team('6')
  end
end
