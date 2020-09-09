require "minitest/autorun"
require "minitest/pride"
require './lib/stat_tracker'
require "./lib/game_statistics"
require "./lib/team_statistics"
require "pry";

class TeamStatisticsTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @game_statistics = GameStatistics.new(@stat_tracker)
    @team_statistics = TeamStatistics.new(@stat_tracker)
  end

  # Each of the methods below take a team id as an argument. Using that team id,
  # your instance of StatTracker will provide statistics for a specific team.

  def test_it_has_attributes
  # A hash with key/value pairs for the following attributes: team_id,
  # franchise_id, team_name, abbreviation, and link

     team_data = {"team_id"      => 1,
                  "franchiseId"  => 23,
                  "teamName"     => "Atlanta United",
                  "abbreviation" => "ATL",
                  "link"         => "/api/v1/teams/1"
    }
    assert_instance_of TeamStatistics, @team_statistics
    assert_equal team_data, @team_statistics.team_info(1)
  end
end
