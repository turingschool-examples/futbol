require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/game_manager'
require './lib/game'

class GameManagerTest < Minitest::Test
  def setup
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams_dummy.csv'
    @game_teams_path = './data/game_teams_dummy.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
require 'pry'; binding.pry
    # assert_instance_of GameManager, @stat_tracker.game_manager
  end
end
