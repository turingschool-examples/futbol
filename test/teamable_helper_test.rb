require './test/test_helper'
require './lib/stat_tracker'
require './lib/teamable'
require './lib/teamable_helper'

class TeamableHelperTest < Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end


  def test_season_array_helper
    expected_array = ["20122013", "20132014", "20142015", "20152016", "20162017", "20172018"]
  assert_equal expected_array, @stat_tracker.season_array_helper
  end

  def test_season_win_loss_helper
    expected_hash = {"20122013"=>{:wins=>17, :games=>48}, "20132014"=>{:wins=>15, :games=>82}, "20142015"=>{:wins=>15, :games=>82}, "20152016"=>{:wins=>32, :games=>82}, "20162017"=>{:wins=>30, :games=>82}, "20172018"=>{:wins=>20, :games=>82}}

  assert_equal expected_hash, @stat_tracker.season_win_loss_helper("7")
  end

  def test_season_win_percentage_helper
    expected_hash = {"20122013"=>0.35, "20132014"=>0.18, "20142015"=>0.18, "20152016"=>0.39, "20162017"=>0.37, "20172018"=>0.24}

  assert_equal expected_hash, @stat_tracker.season_win_percentage_helper("7")
  end

  # needs fixture file
  # def test_games_for_team_helper
  # assert_equal , @stat_tracker.games_for_team_helper
  # end

  def test_total_wins_array_helper
  assert_equal 6.0, @stat_tracker.total_wins_count_helper("7", "14")
  end

  # def test_games_for_team_helper
  # assert_equal , @stat_tracker.games_for_team_helper
  # end
  #
  # def test_total_wins_array_helper
  # assert_equal , @stat_tracker.total_wins_array_helper
  # end
  #

  # def test_total_games_array_helper
  # assert_equal , @stat_tracker.total_games_array_helper
  # end
end
