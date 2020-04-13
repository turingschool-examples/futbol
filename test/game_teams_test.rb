require_relative 'test_helper'
require 'CSV'
require './lib/game_team'
require './lib/game_team'

class GameTeamsTest < Minitest::Test
  def setup
    @game_teams = GameTeams.new("./data/game_teams_truncated.csv")
    @game_team = @game_teams.game_teams.first
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams
  end

  def test_it_can_create_game_teams_from_csv
    assert_instance_of GameTeam, @game_team
    assert_equal 3, @game_team.team_id
    assert_equal "John Tortorella", @game_team.head_coach
  end
end
