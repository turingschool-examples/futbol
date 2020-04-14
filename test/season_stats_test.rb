require_relative 'test_helper'

class SeasonStatsTest < Minitest::Test
  def setup
    @season_stats = SeasonStats.new('./data/teams.csv', './test/fixtures/truncated_game_stats2.csv')
  end

  def test_initialization
    assert_instance_of SeasonStats, @season_stats
  end

  def test_season_stat_percentage
    assert_equal 0.67, @season_stats.season_stat_percentage("20122013", "Mike Babcock", :win).round(2)
    assert_equal 0.22, @season_stats.season_stat_percentage("20122013", 3, :shot).round(2)
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @season_stats.winningest_coach("20122013")
  end

  def test_worst_coach
    assert_equal "John Tortorella", @season_stats.worst_coach("20122013")
  end

  def test_most_accurate_team
    assert_equal "LA Galaxy", @season_stats.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    assert_equal "New England Revolution", @season_stats.least_accurate_team("20122013")
  end

  def test_most_tackles
    assert_equal "FC Dallas", @season_stats.most_tackles("20122013")
  end

  def test_fewest_tackles
    assert_equal "New England Revolution", @season_stats.fewest_tackles("20122013")
  end
end
