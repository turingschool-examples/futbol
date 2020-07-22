require "minitest/autorun"
require "minitest/pride"
require "./lib/team_data"
require "csv"

class TeamDataTest < Minitest::Test

  def setup
    game_path = './data/dummy_file_games.csv'
    team_path = './data/dummy_file_teams.csv'
    game_teams_path = './data/dummy_file_game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @table = CSV.parse(File.read(@locations[:teams]), headers: true)
  end
  
  def test_it_exists
    team_data = TeamData.new

    assert_instance_of TeamData, team_data
  end


end
