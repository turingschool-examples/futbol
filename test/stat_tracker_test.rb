require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    team_path = './data/teams.csv'
    locations = {
      teams: team_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_can_access_data
    assert_equal "4", @stat_tracker[:teams]["team_id"][1]
  end
end
