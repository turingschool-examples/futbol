require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_manager'
require './lib/game_teams_manager'
require './lib/team_manager'
require 'pry';

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

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

  def test_it_can_return_a_count_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_find_a_name
    team_number = '25'
    assert_equal 'Chicago Red Stars', @stat_tracker.find_team_name(team_number)
  end

  
end
