# require 'minitest/autorun'
# require 'minitest/pride'
# require './lib/team_statistics'
# require './lib/team'
#
# class TeamStatisticsTest < Minitest::Test
#
#   def setup
#     @team_statistics = TeamStatistics.new("./data/teams.csv")
#     @team = @team_statistics.teams.first
#   end
#
#   def test_it_exists
#     assert_instance_of TeamStatistics, @team_statistics
#   end
#
#   def test_it_can_create_teams_from_csv
#     assert_instance_of Team, @team
#     assert_equal "1", @team.team_id
#     assert_equal "Atlanta United", @team.team_name
#   end
#
#   def test_it_has_team_info
#     expected = {:team_id => 1,
#                 :franchise_id => 23,
#                 :team_name => "Atlanta United",
#                 :abbreviation => "ATL",
#                 :link => "/api/v1/teams/1"}
#     assert_equal expected, @team_statistics.team_info(1)
#   end
# end
