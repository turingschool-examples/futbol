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

end
