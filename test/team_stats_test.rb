require_relative 'test_helper'
require 'csv'
require './lib/tracker'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_teams'
require './lib/season'
require './lib/collection'
require './lib/game_collection'
require './lib/team_collection'
require './lib/game_teams_collection'
require './lib/season_collection'

class TeamStatsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = Tracker.from_csv(locations)
  end

  def test_team_stats_can_get_favorite_opponent
    assert_equal 'DC United', @stat_tracker.favorite_opponent('18')
  end

  def test_team_stats_can_get_rivals
    assert_includes ['Houston Dash', 'LA Galaxy'], @stat_tracker.rival('18')
  end

  def test_head_to_head
    expected_1 = {
      "Atlanta United"=>0.5,
      "Chicago Fire"=>0.3,
      "FC Cincinnati"=>0.39,
      "DC United"=>0.8,
      "FC Dallas"=>0.4,
      "Houston Dynamo"=>0.4,
      "Sporting Kansas City"=>0.25,
      "LA Galaxy"=>0.29,
      "Los Angeles FC"=>0.44,
      "Montreal Impact"=>0.33,
      "New England Revolution"=>0.47,
      "New York City FC"=>0.6,
      "New York Red Bulls"=>0.4,
      "Orlando City SC"=>0.37,
      "Portland Timbers"=>0.3,
      "Philadelphia Union"=>0.44,
      "Real Salt Lake"=>0.42,
      "San Jose Earthquakes"=>0.33,
      "Seattle Sounders FC"=>0.5,
      "Toronto FC"=>0.33,
      "Vancouver Whitecaps FC"=>0.44,
      "Chicago Red Stars"=>0.48,
      "Houston Dash"=>0.1,
      "North Carolina Courage"=>0.2,
      "Orlando Pride"=>0.47,
      "Portland Thorns FC"=>0.45,
      "Reign FC"=>0.33,
      "Sky Blue FC"=>0.3,
      "Utah Royals FC"=>0.6,
      "Washington Spirit FC"=>0.67,
      "Columbus Crew SC"=>0.5
     }

     expected_2 = {
      "Atlanta United" => 0.6,
      "Chicago Fire" => 0.8,
      "Chicago Red Stars" => 0.63,
      "Columbus Crew SC" => 0.75,
      "DC United" => 1.0,
      "FC Cincinnati" => 0.56,
      "FC Dallas" => 0.7,
      "Houston Dash" => 0.4,
      "Houston Dynamo" => 0.7,
      "LA Galaxy" => 0.36,
      "Los Angeles FC" => 0.56,
      "Montreal Impact" => 0.61,
      "New England Revolution" => 0.63,
      "New York City FC" => 0.8,
      "New York Red Bulls" => 0.7,
      "North Carolina Courage" => 0.5,
      "Orlando City SC" => 0.59,
      "Orlando Pride" => 0.6,
      "Philadelphia Union" => 0.56,
      "Portland Thorns FC" => 0.55,
      "Portland Timbers" => 0.5,
      "Real Salt Lake" => 0.74,
      "Reign FC" => 0.67,
      "San Jose Earthquakes" => 0.67,
      "Seattle Sounders FC" => 0.6,
      "Sky Blue FC" => 0.6,
      "Sporting Kansas City" => 0.44,
      "Toronto FC" => 0.61,
      "Utah Royals FC" => 0.7,
      "Vancouver Whitecaps FC" => 0.63,
      "Washington Spirit FC" => 0.78,
    }

    assert_includes [expected_1, expected_2], @stat_tracker.head_to_head('18')
  end
end
