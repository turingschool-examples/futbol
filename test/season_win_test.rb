require_relative 'test_helper'
require './lib/season_win'

class SeasonWinTest < Minitest::Test

  def setup
    @season_win = SeasonWin.new("18")
    @game_collection = GameCollection.new('./test/fixtures/truncated_games.csv')
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
    assert_equal "20132014", @season_win.best_season("6")
  end

  def test_it_can_return_game_id_by_season
    @game_collection.stubs()
  end
end