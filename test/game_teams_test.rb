require './test/test_helper'
require './lib/game_teams'

class GameTeamsTest < Minitest::Test
  def setup
    @game_team = GameTeam.new({
                                game_id: 2012030221,
                                team_id: "3",
                                hoa: 'away',
                                result: "LOSS",
                                head_coach: "John Tortorella",
                                goals: 2,
                                shots: 8,
                                tackles: 44,
                              })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeam, @game_team
    assert_equal 2012030221, @game_team.game_id
    assert_equal "3", @game_team.team_id
    assert_equal "LOSS", @game_team.result
    assert_equal "John Tortorella", @game_team.head_coach
    assert_equal 2, @game_team.goals
    assert_equal 8, @game_team.shots
    assert_equal 44, @game_team.tackles
  end

  def test_it_can_check_if_team_was_home_or_away
    assert @game_team.away?
    assert_equal false, @game_team.home?
  end

  def test_it_can_check_if_given_id_matches_team_id
    assert @game_team.match?("3")
    assert_equal false, @game_team.match?("54")
  end

  def test_it_can_check_home_or_away
    assert_equal false, @game_team.check('home')
    assert_equal true, @game_team.check('away')
    assert_equal @game_team, @game_team.check
  end
end
