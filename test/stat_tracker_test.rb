require_relative 'test_helper'
require './lib/stat_tracker'
require './lib/stat_tracker'
require './lib/team'
require './lib/game_team'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/fixtures/games_truncated.csv'
    team_path = './test/fixtures/teams_truncated.csv'
    game_teams_path = './test/fixtures/game_teams_truncated.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_create_objects
    assert_instance_of Game, @stat_tracker.games[2]
    assert_instance_of Team, @stat_tracker.teams[2]
    assert_instance_of GameTeam, @stat_tracker.game_teams[2]
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_find_biggest_blowout
    assert_equal 4, @stat_tracker.biggest_blowout
  end

  def test_it_can_find_all_seasons
    assert_equal [20122013, 20132014], @stat_tracker.find_all_seasons
  end

  def test_it_can_calculate_count_of_games_by_season
    assert_equal ({20122013=>51, 20132014=>29}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_average_goals_per_game
    assert_equal 4.01, @stat_tracker.average_goals_per_game
  end

  def test_it_can_average_goals_by_season
    assert_equal ({20122013=>4.02, 20132014=>4.0}), @stat_tracker.average_goals_by_season
  end

  def test_it_can_find_percentage_home_wins
    assert_equal 68.42, @stat_tracker.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 25.0, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_find_percentage_ties
    assert_equal 5.13, @stat_tracker.percentage_ties
  end

end
