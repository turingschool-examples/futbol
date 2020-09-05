require './test/test_helper'
require './lib/stat_tracker'

class TeamStatisticsTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new("games", StatTracker.generate_teams('./data/teams.csv'), "game_teams")
  end

  def test_team_info
    expected ={
           team_id: 1,
      franchise_id: 23,
         team_name: "Atlanta United",
      abbreviation: "ATL",
           stadium: "Mercedes-Benz Stadium",
              link: "/api/v1/teams/1"
    }
    actual = @stat_tracker.team_info(1)

    assert_equal expected, actual
  end 
end
