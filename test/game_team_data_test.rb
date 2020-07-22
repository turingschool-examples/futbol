require "minitest/autorun"
require "minitest/pride"
require "./lib/game_team_data"
require "csv"

class GameTeamDataTest < Minitest::Test

  def setup
    game_path = './data/dummy_file_games.csv'
    team_path = './data/dummy_file_teams.csv'
    game_teams_path = './data/dummy_file_game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @table = CSV.parse(File.read('./data/dummy_file_game_teams.csv'), headers: true)
  end

  def test_it_exists
    game_team_data = GameTeamData.new
    assert_instance_of GameTeamData, game_team_data
  end

end
