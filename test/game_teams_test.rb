require "./test/test_helper.rb"
class GameTeamstest < MiniTest::Test

  def test_it_exists
    game_path = './data/games.csv'
     team_path = './data/teams.csv'
     game_teams_path = './data/game_teams.csv'

     locations = {
       games: game_path,
       teams: team_path,
       game_teams: game_teams_path
     }
    info = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    game_team = GameTeam.new(info.first)
    assert_instance_of GameTeam, game_team
  end

  def test_it_has_attributes
    game_path = './data/games.csv'
     team_path = './data/teams.csv'
     game_teams_path = './data/game_teams.csv'

     locations = {
       games: game_path,
       teams: team_path,
       game_teams: game_teams_path
     }
    info = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    game_team = GameTeam.new(info.first)
    assert_equal "44.8", game_team.face_off_win_percentage
    assert_equal "2012030221", game_team.game_id
    assert_equal "17", game_team.giveaways
    assert_equal "2", game_team.goals
    assert_equal "John Tortorella", game_team.head_coach
    assert_equal "away", game_team.hoa
    assert_equal "8", game_team.pim
    assert_equal "0", game_team.power_play_goals
    assert_equal "3", game_team.power_play_opportunities
    assert_equal "LOSS", game_team.result
    assert_equal "OT", game_team.settled_in
    assert_equal "8", game_team.shots
    assert_equal "44", game_team.tackles
    assert_equal "7", game_team.takeaways
    assert_equal "3", game_team.team_id
  end
end
