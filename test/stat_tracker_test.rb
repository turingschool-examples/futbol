require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def test_it_exists
    tracker = StatTracker.new([], [], [])

    assert_instance_of StatTracker, tracker
  end

  ####### Game Stats ########

  ###########################

  ###### Team Stats #########

  ###########################

  ###### League Stats #######

  ###########################

  ###### Season Stats #######

  ###########################
end
