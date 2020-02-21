require_relative 'test_helper'
require './lib/season_win'

class SeasonWinTest < Minitest::Test

  def setup
    @season_win = SeasonWin.new("18")
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

  def test_it_can_return_worst_season
    assert_equal "20142015", @season_win.worst_season("6")
  end

  def test_it_can_return_game_id_by_season
    assert_instance_of Hash, @season_win.game_id_by_season("6")
    assert_equal ["20122013", "20172018", "20132014", "20142015", "20152016", "20162017"], @season_win.game_id_by_season("6").keys
    assert_equal 70, @season_win.game_id_by_season("6")["20122013"].length
    assert_equal "2012030221", @season_win.game_id_by_season("6")["20122013"].first
  end


end