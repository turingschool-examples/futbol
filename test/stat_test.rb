require './test/test_helper'
require './lib/stat_tracker'
require 'active_support'

class StatTrackerTest < Minitest::Test
  def test_has_attributes
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    tracker = StatTracker.from_csv(locations)
    refute_equal [], tracker[0][0]
    assert_equal tracker[0][0], {:game_id=>2012030221, :season=>20122013, :type=>"Postseason", :date_time=>"5/16/13", :away_team_id=>3, :home_team_id=>6, :away_goals=>2, :home_goals=>3, :venue=>"Toyota Stadium", :venue_link=>"/api/v1/venues/null"}
  end


end