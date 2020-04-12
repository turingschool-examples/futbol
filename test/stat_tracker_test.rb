require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
#

class StatTrackerTest < Minitest::Test

  def setup
    @game_path = './test/fixtures/games_20.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './test/fixtures/game_teams_40.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal "./test/fixtures/game_teams_40.csv", @stat_tracker.game_teams_path
    assert_equal "./test/fixtures/games_20.csv", @stat_tracker.games_path
    assert_equal "./data/teams.csv", @stat_tracker.teams_path
  end

  def test_it_creates_games
    assert_instance_of Array, @stat_tracker.games
    assert_instance_of Game, @stat_tracker.games[0]
  end

  def test_it_creates_teams
    assert_instance_of Array, @stat_tracker.teams
    assert_instance_of Team, @stat_tracker.teams[0]
  end

  def test_it_creates_game_teams
    assert_instance_of Array, @stat_tracker.game_teams
    assert_instance_of GameTeam, @stat_tracker.game_teams[0]
  end

  def test_it_can_find_number_of_home_games
    assert_equal 20, @stat_tracker.home_games
  end

  def test_it_can_find_percent_home_wins
    assert_equal 60.00, @stat_tracker.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 20.00, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_find_percentage_ties
    assert_equal 25.00, @stat_tracker.percentage_ties
  end

  def test_it_can_count_games_in_a_season
    assert_equal ({20122013=>2, 20162017=>5, 20142015=>6, 20132014=>4, 20152016=>2, 20172018=>1}), @stat_tracker.count_of_games_by_season
  end

#Michelle start

  def test_it_can_find_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_can_find_lowest_total_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_it_can_return_team_name_with_most_tackles
    assert_equal "FC Dallas", @stat_tracker.most_tackles(20122013)
  end

  def test_it_can_return_team_name_with_fewest_tackles
    assert_equal "Washington Spirit FC", @stat_tracker.fewest_tackles(20122013)
  end
  #michelle end
end
