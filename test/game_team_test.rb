require 'minitest/pride'
require 'minitest/autorun'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @game_team = GameTeam.from_csv('./data/dummy_game_team.csv')
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team.first
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game_team.first.game_id
    assert_equal 3, @game_team.first.team_id
    assert_equal "away", @game_team.first.hoa
    assert_equal "LOSS", @game_team.first.result
    assert_equal "OT", @game_team.first.settled_in
    assert_equal "John Tortorella", @game_team.first.head_coach
    assert_equal 2, @game_team.first.goals
    assert_equal 8, @game_team.first.shots
    assert_equal 44, @game_team.first.tackles
    assert_equal 8, @game_team.first.pim
    assert_equal 3, @game_team.first.powerplayopportunities
    assert_equal 0, @game_team.first.powerplaygoals
    assert_equal 44.8, @game_team.first.faceoffwinpercentage
    assert_equal 17, @game_team.first.giveaways
    assert_equal 7, @game_team.first.takeaways
  end

  def test_percentage_vistor_team_wins
    assert_equal 33, GameTeam.percentage_visitor_wins
  end

end
