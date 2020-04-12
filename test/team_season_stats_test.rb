require_relative 'test_helper'

class TeamSeasonStatsTest < Minitest::Test
  def setup
    @team_stats = TeamSeasonStats.new("./test/fixtures/truncated_games.csv")
  end

  def test_it_exists
    assert_instance_of TeamSeasonStats, @team_stats
  end

  def test_can_find_games
    assert_equal 29, @team_stats.all_games(17).count
  end

  def test_can_sort_games_by_season
    skip
    game1 = mock('game 1')
    game2 = mock('game 2')
    game3 = mock('game 3')

    @team_stats.stubs(:all_games).returns([game1, game2, game3])

    assert_equal 2, @team_stats.all_games_by_season(5)
  end

  def test_can_count_games_by_season
    expected = {"20122013"=>26, "20152016"=>5, "20142015"=>5}
    assert_equal expected, @team_stats.count_all_games_in_season(5)
  end
end
