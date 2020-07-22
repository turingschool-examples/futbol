require "minitest/autorun"
require "minitest/pride"
require "./lib/game_data"
require "csv"

class GameDataTest < Minitest::Test

  def setup
    game_path = './data/dummy_file_games.csv'
    team_path = './data/dummy_file_teams.csv'
    game_teams_path = './data/dummy_file_game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @game_data = GameData.new
    @table = CSV.parse(File.read('./data/dummy_file_games.csv'), headers: true)
  end

  def test_it_exists
    assert_instance_of GameData, @game_data
  end

  def test_it_can_create_many_objects
    
  end

end
