# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team'

class GameTeamTest < Minitest::Test
  def setup
    @test1 = GameTeam.new(game_id:"2012020059", team_id:"16", hoa:"away", result:"WIN", settled_in:"REG", head_coach:"Joel Quenneville", goals:"3", shots:"6", tackles:"12", pim:"17", powerplayopportunities:"3", powerplaygoals:"0", faceoffwinpercentage:"47.4", giveaways:"1", takeaways:"2")
  end

  def test_it_exists
    assert_instance_of GameTeam, @test1
  end

  def test_has_attributes
    assert_equal 2012020059, @test1.game_id
    assert_equal 16, @test1.team_id
    assert_equal 'away', @test1.hoa
    assert_equal 'WIN', @test1.result
    assert_equal 'REG', @test1.settled_in
    assert_equal 'Joel Quenneville', @test1.head_coach
    assert_equal 3, @test1.goals
    assert_equal 6, @test1.shots
    assert_equal 12, @test1.tackles
    assert_equal 17, @test1.pim
    assert_equal 3, @test1.power_play_opportunities
    assert_equal 0, @test1.power_play_goals
    assert_equal 47.4, @test1.face_off_win_percentage
    assert_equal 1, @test1.giveaways
    assert_equal 2, @test1.takeaways
  end
end
