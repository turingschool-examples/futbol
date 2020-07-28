require "minitest/autorun"
require "minitest/pride"
require "./lib/team_statistics"
require 'mocha/minitest'

class TeamStatisticsTest < Minitest::Test

  def setup
    @team_stats = TeamStatistics.new
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_stats
  end

  def test_it_can_create_team_hash_details
    expected = {"team_id"=>"3", "franchise_id"=>"10", "team_name"=>"Houston Dynamo", "abbreviation"=>"HOU", "link"=>"/api/v1/teams/3"}
    assert_equal expected, @team_stats.team_info("3")
  end

  def test_it_can_return_best_and_worst_season_by_team_id
    skip
    assert_equal "20122013", @team_stats.best_season("6")
    assert_equal "20122013", @team_stats.worst_season("17")
  end

  def test_it_can_calc_win_percentage_by_team_id
    skip
    assert_equal 0.57, @team_stats.average_win_percentage("17")
  end

  def test_it_can_print_most_and_fewest_goals_scored_by_team_id
    skip
    assert_equal "4", @team_stats.most_goals_scored("6")
    assert_equal "1", @team_stats.fewest_goals_scored("6")
  end

  def test_it_can_return_favorite_opponent_or_rival_by_team
    skip
    assert_equal "New England Revolution", @team_stats.favorite_opponent("17")
    assert_equal "New York Red Bulls", @team_stats.rival("9")
  end

end
