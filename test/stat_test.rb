require './test/test_helper'
require './lib/stat_tracker'
require 'active_support'

class StatTrackerTest < Minitest::Test
  def test_has_attributes
    locations = {path: './data/teams_test.csv'}
    tracker = StatTracker.from_csv(locations)
    
    refute_equal [], tracker[0][0]
    assert_equal tracker[0][0], {:team_id=>1, :franchiseid=>23, :teamname=>"Atlanta United", :abbreviation=>"ATL", :stadium=>"Mercedes-Benz Stadium", :link=>"/api/v1/teams/1"}
  end

end