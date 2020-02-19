require_relative "./test_helper"
require "./lib/stat_tracker"
require "./lib/game"
require "./lib/team"
require "./lib/game_team"

class TeamStatsTest < MiniTest::Test
  def setup
    StatTracker.create_items("./test/fixtures/teams_sample.csv", Team)
  end

  def test_it_can_get_team_info
    expected = {
      team_id: 7,
      franchise_id: 19,
      teamName: 'Utah Royals FC',
      abbreviation: 'URF',
      Stadium: 'Rio Tinto Stadium',
      link: '/api/v1/teams/7'
    }

    assert_equal expected, new_team.team_info(7)
  end

  def test_it_can_get_best_season
    assert_equal 'season', @@team.best_season(7)
  end

  def test_it_can_get_worst_season
    assert_equal 'season', @@team.best_season(7)
  end

  def test_it_can_get_average_win_percentage
    assert_equal 0.00, @@team.average_win_percentage(7)
  end

  def test_it_can_get_most_goals_scored
    assert_equal 4, @@team.most_goals_scored(7)
  end

  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @@team.fewest_goals_scored(7)
  end

  def test_it_can_get_favorite_opponent
    assert_equal 'team_name', @@team.favorite_opponent(7)
  end

  def test_it_can_get_rival
    assert_equal 'team_name', @@team.favorite_opponent(7)
  end

  def test_it_can_get_biggest_team_blowout
    assert_equal 0, @@team.biggest_team_blowout(7)
  end

  def test_it_can_get_worst_loss
    assert_equal 0, @@team.worst_loss(7)
  end

  def test_it_can_get_head_to_head
    assert_equal {}, @@team.head_to_head(7)
  end

  def test_it_can_get_seasonal_summary
    assert_equal {}, @@team.seasonal_summary(7)
  end
end
