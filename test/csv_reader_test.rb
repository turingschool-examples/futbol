require_relative 'test_helper'

class CsvReaderTest < Minitest::Test

  def test_it_exits
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    csv_reader = CsvReader.new

    assert_instance_of CsvReader, csv_reader
    require "pry"; binding.pry
  end

end
