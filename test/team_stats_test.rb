require './test/test_helper'
require './lib/team_stats'
require './lib/stat_tracker'

class TeamStatsTest < MiniTest::Test

  def setup
    stat_tracker = StatTracker.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
      @team_stats = stat_tracker.team_stats
  end

  def test_it_finds_team_info
    assert_equal ({"team_id" => "1",
      "franchise_id" => "23",
      "team_name" => "Atlanta United",
      "abbreviation" => "ATL",
      "link" => "/api/v1/teams/1"}), @team_stats.team_info("1")
  end

  def test_it_can_find_teams_best_season
    assert_equal '20172018', @team_stats.best_season('52')
  end

  def test_it_can_find_teams_worst_season
    assert_equal '20172018', @team_stats.worst_season('52')
  end

  def test_it_can_find_the_average_winrate_for_a_team
     assert_equal  0.2 , @team_stats.average_win_percentage("30")
  end

  def test_most_goals_scored
    assert_equal 4, @team_stats.most_goals_scored("6")
  end

  def test_fewest_goals_scored
    assert_equal 0, @team_stats.fewest_goals_scored("30")
  end

  def test_find_favorite_opponent
    assert_equal "LA Galaxy", @team_stats.favorite_opponent("29")
  end

  def test_find_rival
    assert_equal "Real Salt Lake", @team_stats.rival("29")
  end

end
