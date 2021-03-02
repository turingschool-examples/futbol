require "minitest/autorun"
require "minitest/pride"
require './lib/tables/game_table'
require "./lib/instances/game"
require './test/test_helper'
require './lib/stat_tracker'
require './lib/tables/team_table'
require './lib/tables/game_team_tables'
class TeamTest < Minitest::Test

  def setup
    @teams = TeamsTable.new('./data/teams.csv')
    @game_teams = GameTeamTable.new('./data/game_teams.csv')
  end

  def test_number_of_teams
    assert_equal @teams.count_of_teams, 32
  end
end
