require_relative 'test_helper'
require './lib/season_win'

class SeasonWinTest < Minitest::Test

  def setup
    team_file_path = './data/teams.csv'
    game_team_file_path = './test/fixtures/truncated_game_teams.csv'
    game_file_path = './test/fixtures/truncated_games.csv'
    @season_win = SeasonWin.new(team_file_path, game_team_file_path, game_file_path)
  end

  def test_it_exists
    assert_instance_of SeasonWin, @season_win
  end

  def test_it_can_return_team_info
    expected = { "team_id" => "18", "franchise_id" => "34",
                 "team_name" => "Minnesota United FC",
                 "abbreviation" => "MIN",
                 "link" => "/api/v1/teams/18" }

    assert_equal expected, @season_win.team_info("18")
  end

  def test_it_can_return_best_season
    assert_equal "20142015", @season_win.best_season("3")
  end

  def test_it_can_return_worst_season
    assert_equal "20122013", @season_win.worst_season("3")
  end

  def test_it_can_return_total_games_played
    assert_instance_of Hash, @season_win.total_games_by_season("3")
    assert_equal 12, @season_win.total_games_by_season("3")["20122013"]
    assert_equal 11, @season_win.total_games_by_season("3")["20142015"]
    assert_equal 5, @season_win.total_games_by_season("3")["20152016"]
  end

  def test_it_can_return_winning_game_ids
    assert_instance_of Hash, @season_win.winning_game_ids("3")
    assert_equal 2, @season_win.winning_game_ids("3").length
    assert_equal 2, @season_win.winning_game_ids("3")["20122013"]
    assert_equal 8, @season_win.winning_game_ids("3")["20142015"]
    assert_equal ["20122013", "20142015"], @season_win.winning_game_ids("3").keys
  end

  def test_it_can_return_average_wins
    assert_instance_of Hash, @season_win.average_wins_by_team_per_season("3")
    assert_equal 16.67, @season_win.average_wins_by_team_per_season("3")["20122013"]
    assert_equal 72.73, @season_win.average_wins_by_team_per_season("3")["20142015"]
  end
end