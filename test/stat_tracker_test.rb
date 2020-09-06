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

    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score

    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_it_can_calculate_percentage_home_wins

    assert_equal 0.60, @stat_tracker.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins

    assert_equal 0.20, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties

    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  def test_it_can_count_games_by_season

    assert_equal ({'20132014' => 2, '20122013' => 3}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_average_goals_per_game

    assert_equal 5.00, @stat_tracker.average_goals_per_game
  end
end
