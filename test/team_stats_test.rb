require_relative "./test_helper"
require "./lib/stat_tracker"
require "./lib/game"
require "./lib/team"
require "./lib/game_team"
require "./lib/team_stats"

class TeamStatsTest < MiniTest::Test


  def test_it_can_get_best_season
    skip
    assert_equal 'season', @@team.best_season(7)
  end

  def test_it_can_get_worst_season
    skip
    assert_equal 'season', @@team.best_season(7)
  end

  def test_it_can_get_average_win_percentage
    skip
    assert_equal 0.00, @@team.average_win_percentage(7)
  end

  def test_it_can_get_most_goals_scored
    skip
    assert_equal 4, @@team.most_goals_scored(7)
  end

  def test_it_can_get_fewest_goals_scored
    skip
    assert_equal 0, @@team.fewest_goals_scored(7)
  end

  def test_it_can_get_favorite_opponent
    skip
    assert_equal 'team_name', @@team.favorite_opponent(7)
  end

  def test_it_can_get_rival
    skip
    assert_equal 'team_name', @@team.favorite_opponent(7)
  end

  def test_it_can_get_biggest_team_blowout
    skip
    assert_equal 0, @@team.biggest_team_blowout(7)
  end

  def test_it_can_get_worst_loss
    skip
    assert_equal 0, @@team.worst_loss(7)
  end

  def test_it_can_get_head_to_head
    skip
    # assert_equal {}, @@team.head_to_head(7)
  end

  def test_it_can_get_seasonal_summary
    skip
    # assert_equal {}, @@team.seasonal_summary(7)
  end
end
