require './test/test_helper'

class StatTrackerTest < MiniTest::Test

  def setup
    locations = {
      games: './data/fixture_files/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/fixture_files/game_teams.csv'
    }
    require 'pry'; binding.pry
    @stat_tracker = StatTracker.from_csv(locations)
  end

# Game Statistics Methods
  def test_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

# League Statistics Methods
  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end
