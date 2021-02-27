require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
# require './test/test_helper'
require './lib/games_manager'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './dummy_data/games_dummy.csv'
    @team_path = './dummy_data/teams_dummy.csv'
    @game_teams_path = './dummy_data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
    # @stat_tracker_instance = StatTracker.new(@locations)
  end

  def test_it_exists
    # skip
    assert_instance_of StatTracker, @stat_tracker
  end

  # Game Statistics Tests
  def test_it_can_find_highest_score
    # stat_tracker = StatTracker.from_csv(@locations)
    assert_equal 5, @stat_tracker.highest_total_score
  end

  #League Statistics Tests
  def test_it_can_count_number_of_teams
    # skip
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_name_team_with_most_tackles
    assert_equal "FC Dallas", @stat_tracker.most_tackles
  end

end
