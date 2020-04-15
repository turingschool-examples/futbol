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

  def test_info_by_season
    names = ["John Tortorella", "Claude Julien", "Mike Babcock", "Joel Quenneville"]
    ids = [3, 6, 17, 16]
    tackles = {3=>114, 6=>115, 17=>97, 16=>82}
    shots = {3=>23, 6=>28, 17=>19, 16=>25}
    goals = {3=>5, 6=>8, 17=>6, 16=>4}
    wins = {6=>3, 16=>1, 17=>2}
    games = @season_stats.games_by_season("20122013", @season_stats.game_stats)

    assert_equal names ,@season_stats.info_by_season(games, :head_coach)
    assert_equal ids ,@season_stats.info_by_season(games, :team_id)
    assert_equal tackles ,@season_stats.info_by_season(games, :team_tackles)
    assert_equal shots ,@season_stats.info_by_season(games, :team_shots)
    assert_equal goals ,@season_stats.info_by_season(games, :team_goals)
    assert_equal wins ,@season_stats.info_by_season(games, :team_wins)
  end
end
