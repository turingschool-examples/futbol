require "./lib/league_statistics"
require "minitest/autorun"
require "minitest/pride"

class LeagueStatisticsTest < MiniTest::Test

  def setup
    game_path = './league_stats_fixtures/games_fixtures.csv'
    team_path = './league_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './league_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = LeagueStatistics.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of LeagueStatistics, @stat_tracker
    assert_equal './league_stats_fixtures/games_fixtures.csv', @stat_tracker.games
    assert_equal './league_stats_fixtures/teams_fixtures.csv', @stat_tracker.teams
    assert_equal './league_stats_fixtures/game_teams_fixtures.csv', @stat_tracker.game_teams
  end

  # League Statistics
  def test_count_of_teams
    assert_instance_of Integer, @stat_tracker.count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_convert_team_id_to_name
    assert_equal "FC Dallas", @stat_tracker.team_name(6)
  end

  def test_team_scores
    expected = {
      "3"=>[2, 2, 1, 2, 1],
      "6"=>[3, 3, 2, 3, 3, 3, 4, 2, 1],
      "5"=>[0, 1, 1, 0],
      "17"=>[1, 2, 3, 2, 1, 3, 1],
      "16"=>[2, 1, 1, 0, 2, 2, 2],
      "9"=>[2, 1, 4],
      "8"=>[2, 3, 1]
    }
    assert_equal expected, @stat_tracker.team_scores
  end

  def test_teams_average_score
    expected = {
      "3"=>1.60,
      "6"=>2.67,
      "5"=>0.50,
      "17"=>1.86,
      "16"=>1.43,
      "9"=>2.33,
      "8"=>2.00
    }
    assert_equal expected, @stat_tracker.average_team_scores
  end

  def test_best_offense
    assert_instance_of String, @stat_tracker.best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_instance_of String, @stat_tracker.worst_offense
    assert_equal "Sporting Kansas City", @stat_tracker.worst_offense
  end

  def test_visitor_scores
    expected = {
      "3"=>[2, 2, 1],
      "6"=>[2, 3, 3, 4],
      "5"=>[1, 0],
      "17"=>[1, 2, 1, 1],
      "16"=>[1, 0, 2],
      "9"=>[2, 1],
      "8"=>[1]
    }
    assert_equal expected, @stat_tracker.visitor_scores
  end

  def test_average_visitor_scores
    expected = {
      "3"=>1.67,
      "6"=>3.00,
      "5"=>0.50,
      "17"=>1.25,
      "16"=>1.00,
      "9"=>1.50,
      "8"=>1.00
    }
    assert_equal expected, @stat_tracker.average_visitor_scores
  end

  def test_highest_scoring_visitor
    assert_instance_of String, @stat_tracker.highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_instance_of String, @stat_tracker.lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_visitor
  end

  def test_home_team_scores
    expected = {
      "6"=>[3, 3, 3, 2, 1],
      "3"=>[1, 2],
      "5"=>[0, 1],
      "16"=>[2, 1, 2, 2],
      "17"=>[3, 2, 3],
      "8"=>[2, 3],
      "9"=>[4]
    }
    assert_equal expected, @stat_tracker.home_team_scores
  end

  def test_average_home_team_scores
    expected = {
      "6"=>2.4,
      "3"=>1.5,
      "5"=>0.5,
      "16"=>1.75,
      "17"=>2.67,
      "8"=>2.5,
      "9"=>4.0
    }
    assert_equal expected, @stat_tracker.average_home_team_scores
  end

  def test_highest_scoring_home_team
    assert_instance_of String, @stat_tracker.highest_scoring_home_team
    assert_equal "New York City FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_instance_of String, @stat_tracker.lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_home_team
  end
end
