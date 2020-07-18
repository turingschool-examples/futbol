require "minitest/autorun"
require "minitest/pride"
require "./lib/game_statistics"
require 'csv'
require 'pry'

class GameStatisticsTest < MiniTest::Test

  def setup
    game_path = './data/dummy_file_games.csv'
    team_path = './data/dummy_file_teams.csv'
    game_teams_path = './data/dummy_file_game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end

  def test_it_exists
    game_statistics = GameStatistics.new
    assert_instance_of GameStatistics, game_statistics
  end

  def test_highest_total_score
    skip
    assert_equal 5, game_statistics.highest_total_score
  end

  def test_parse_games
    expected = [
                ["2012030221",
                  "20122013",
                  "Postseason",
                  "5/16/13",
                  "3","6","2","3",
                  "Toyota Stadium",
                  "/api/v1/venues/null"]
              ]

    assert_equal expected, CSV.parse("2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null")
  end

  def test_read_csv_file
    skip
    array_dummy = CSV.read('./data/dummy_file_games.csv')

  end

  def test_create_keys
    array_dummy = CSV.read('./data/dummy_file_games.csv')
    game_statistics = GameStatistics.new()
    game_statistics.create_stat_keys(array_dummy)
    expected = {
                "game_id"=>0,
                "season"=>0,
                "type"=>0,
                "date_time"=>0,
                "away_team_id"=>0,
                "home_team_id"=>0,
                "away_goals"=>0,
                "home_goals"=>0,
                "venue"=>0,
                "venue_link"=>0
              }

    assert_equal expected, game_statistics.stat_hash
  end

  def test_create_stat_has_keys

  end
end
