require_relative 'test_helper'
require './lib/game_collection'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new("./data/test_game_data.csv", "./data/games.csv", "./data/teams.csv")
    @game_1 = Game.new([1, 1, "Postseason", "5/16/13", 3, 6, 2, 3, "Toyota Stadium", "/api/v1/venues/null"])
    @game_2 = Game.new([2, 1, "Postseason", "5/21/13", 6, 3, 2, 1, "BBVA Stadium", "/api/v1/venues/null"])
    @game_3 = Game.new([3, 1, "Postseason", "5/25/13", 3, 6, 1, 3, "Toyota Stadium", "/api/v1/venues/null"])
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_calculate_highest_goal_total
    # not sure how to test this from dummy data
    assert_equal 5, @stat_tracker.highest_total_score
  end
end
