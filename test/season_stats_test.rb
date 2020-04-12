require_relative 'test_helper'

class SeasonStatsTest < Minitest::Test
  def setup
    @teams_col = TeamCollection.new('./data/teams.csv')
    @game_stats_col = GameStatsCollection.new('./test/fixtures/truncated_game_stats2.csv')
    @season_stats = SeasonStats.new(@teams_col, @game_stats_col)
  end

  def test_initialization_with_attributes
    assert_instance_of SeasonStats, @season_stats
    assert_equal @game_stats_col, @season_stats.game_stats
    assert_equal @teams_col, @season_stats.teams
  end

  def test_get_games_of_season
    assert_equal 12, @season_stats.get_games_of_season("20122013").length
  end

  def test_find_num_games_played_won_in_season
    result = {:games_played => 3, :games_won => 1}
    assert_equal result, @season_stats.find_num_games_played_won_in_season("20122013", "16")
  end

  def test_calc_season_win_percentage
    assert_equal 0.67, @season_stats.calc_season_win_percentage("20122013", "17")
  end

end
