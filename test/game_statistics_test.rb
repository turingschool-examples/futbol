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


end
