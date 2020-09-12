require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_manager'
require './lib/game_teams_manager'
require './lib/team_manager'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists

    assert_instance_of StatTracker, @stat_tracker
  end

  # def test_it_can_access_data
  #   assert_equal '4', @stat_tracker[:teams]['team_id'][1]
  # end
end
