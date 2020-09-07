require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    games = "games"
    teams = "teams"
    game_teams = "game_teams"
    stat_tracker = StatTracker.new(games, teams, game_teams)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_initializes_with_from_csv

    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_inherit_csv_data

    assert_instance_of CSV::Table, @stat_tracker.games
    assert_instance_of CSV::Table, @stat_tracker.teams
    assert_instance_of CSV::Table, @stat_tracker.game_teams
  end

  def test_it_can_calculate_highest_total_score

    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score

    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_it_can_calculate_percentage_home_wins

    assert_equal 0.50, @stat_tracker.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins

    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties

    assert_equal 0.17, @stat_tracker.percentage_ties
  end

  def test_it_can_count_games_by_season

    assert_equal ({"20132014"=>2, "20122013"=>4}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_average_goals_per_game

    assert_equal 5.33, @stat_tracker.average_goals_per_game
  end

  def test_it_can_average_goals_by_season

    assert_equal ({'20132014' => 4.0, '20122013' => 6.0}), @stat_tracker.average_goals_by_season
  end

  def test_it_can_count_total_number_of_teams
    assert_equal 12, @stat_tracker.count_of_teams
  end

  def test_it_can_get_name_of_team_with_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_it_can_name_of_team_with_worst_offense
    assert_equal "Houston Dynamo", @stat_tracker.worst_offense
  end

  def test_can_find_highest_scoring_visitor
    assert_equal "Real Salt Lake", @stat_tracker.highest_scoring_visitor
  end

  def test_can_find_highest_scoring_home_team
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_home_team
  end

  def test_can_find_lowest_scoring_visitor
    assert_equal "Philadelphia Union", @stat_tracker.lowest_scoring_visitor
  end

  def test_can_find_lowest_scoring_home_team
    assert_equal "Chicago Fire", @stat_tracker.lowest_scoring_home_team
  end
end
