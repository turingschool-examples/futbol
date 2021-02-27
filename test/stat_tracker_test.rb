require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
# require './test/test_helper'
require './lib/games_manager'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
    # @stat_tracker_instance = StatTracker.new(@locations)
  end

  def test_it_exists
    skip
    assert_instance_of StatTracker, @stat_tracker
  end

  # Game Statistics Tests
  def test_it_can_find_highest_score
    skip
    # stat_tracker = StatTracker.from_csv(@locations)
    assert_equal 11, @stat_tracker.highest_total_score
  end

  #League Statistics Tests
  def test_it_can_count_number_of_teams
    skip
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_name_team_with_most_tackles
    skip
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  #Team Statistics
  def test_it_can_list_team_info
    skip

    expected = {
     "team_id" => "18",
     "franchise_id" => "34",
     "team_name" => "Minnesota United FC",
     "abbreviation" => "MIN",
     "link" => "/api/v1/teams/18"
   }

   assert_equal @stat_tracker.team_info("18"), expected
  end

  def test

  end

end
