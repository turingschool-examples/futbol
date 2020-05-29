require './test/setup'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    @game_team = GameTeam.new({
      game_id: "2012030221",
      team_id: "3",
      hoa: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: "2"
      })
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game_team.game_id
    assert_equal 3, @game_team.team_id
    assert_equal "away", @game_team.hoa
    assert_equal "LOSS", @game_team.result
    assert_equal "OT", @game_team.settled_in
    assert_equal "John Tortorella", @game_team.head_coach
    assert_equal 2, @game_team.goals
  end

  def test_can_create_all_game_teams_from_csv
    game_team_path = './fixtures/teams_fixture.csv'
    game_teams = GameTeam.all(game_team_path)
    assert_instance_of Array, game_teams
    assert_equal 6, game_teams.count
  end

end
