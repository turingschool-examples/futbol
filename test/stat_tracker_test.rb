require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'
require './runner'
require 'csv'

class StatTrackerTest < Minitest::Test
  def setup
    @teams = 0
    @games = 0
    @game_teams = 0
    @tracker = StatTracker.new(@teams, @games, @game_teams)
  end

  def test_it_exists
    assert_instance_of StatTracker, @tracker
  end

  def test_it_has_attributes
    self.from_csv(locations)
  end
end
