require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/game_teams"

class GameTeamsTest < Minitest::Test

  def setup
    game_teams_param = {
      :game_id => "2012030221",
      :team_id => "3",
      :hoa => "away",
      :result => "LOSS",
      :head_coach => "John Tortorella",
      :goals => "2",
      :shots => "8",
      :tackles => "44"
    }
    @game_teams = GameTeams.new(game_teams_param)
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams
  end

  def test_it_has_attributes
    assert_equal "2012030221", @game_teams.game_id
    assert_equal "3", @game_teams.team_id
    assert_equal "away", @game_teams.hoa
    assert_equal "LOSS", @game_teams.result
    assert_equal "John Tortorella", @game_teams.head_coach
    assert_equal 2, @game_teams.goals
    assert_equal 8, @game_teams.shots
    assert_equal 44, @game_teams.tackles
  end

end
