require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @teams_test_path = './data/teams_test.csv'
    @games_test_path = './data/games_test.csv'
    @game_teams_test_path = './data/game_teams_test.csv'
    @locations = {
      teams_test: @teams_test_path,
      games_test: @games_test_path,
      game_teams_test: @game_teams_test_path
    }
    @tracker = StatTracker.from_csv(@locations)
  end
  
  def test_has_attributes

    
    assert_equal 1, @tracker[:teams_test][0][:team_id]
  end
  def test_highest_total_score
    skip
    locations = {path: './data/games_test.csv'}
    tracker = StatTracker.from_csv(locations)
    require 'pry'; binding.pry
    refute_equal [], tracker[0][0]
    assert_equal tracker[0][0], {:team_id=>1, :franchiseid=>23, :teamname=>"Atlanta United", :abbreviation=>"ATL", :stadium=>"Mercedes-Benz Stadium", :link=>"/api/v1/teams/1"}
  end

  def test_highest_score
    
  end

end
