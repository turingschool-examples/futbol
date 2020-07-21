require "./test/test_helper.rb"
class Teamtest < MiniTest::Test

  def test_it_exists
    game_path = './data/games.csv'
     team_path = './data/teams.csv'
     game_teams_path = './data/game_teams.csv'

     locations = {
       games: game_path,
       teams: team_path,
       game_teams: game_teams_path
     }
    info = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    team = Team.new(info.first)
    assert_instance_of Team, team
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
    info = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    team = Team.new(info.first)
    assert_equal "ATL", team.abbreviation
    assert_equal "23", team.franchise_id
    assert_equal "/api/v1/teams/1", team.link
    assert_equal "Mercedes-Benz Stadium", team.stadium
    assert_equal "1", team.team_id
    assert_equal "Atlanta United", team.team_name
  end


end
