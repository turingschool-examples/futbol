require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game_team'

class GameTeamTest < Minitest::Test

  def test_it_exists
    game_team = GameTeam.new({})
    assert_instance_of GameTeam, game_team
  end

  def test_it_has_attributes
    game_team = GameTeam.new({team_id: 1, hoa: "home", result: 'WIN', goals: "1"})

    assert_equal 1, game_team.team_id
    assert_equal "home", game_team.HoA
    assert_equal "WIN", game_team.result
    assert_equal 1, game_team.goals
  end

end
