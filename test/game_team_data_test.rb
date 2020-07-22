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

  def test_it_can_create_many_objects
    line_index = 0
    all_team_data = []
    @table.size.times do
      team_data = TeamData.new
      team_data.create_attributes(@table, line_index)
      all_team_data << team_data
      line_index += 1
    end
    assert_equal 19, all_team_data.size
  end

end
