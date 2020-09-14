require_relative 'test_helper'

class CsvReaderTest < Minitest::Test

  def test_it_exits_with_attributes
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    csv_reader = CsvReader.new(game_path, team_path, game_teams_path)

    game_from_game_stats = {

    }
    assert_instance_of CsvReader, csv_reader
    assert_equal 2012030221, csv_reader.game_stats_data.first.game_id
    assert_equal "John Tortorella", csv_reader.game_teams_stats_data.first.head_coach
    assert_equal "Atlanta United", csv_reader.teams_stats_data.first.teamname
  end

end
