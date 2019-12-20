require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    our_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

   @stat_tracker = StatTracker.from_csv(our_locations)
 end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_instance_of Array, @stat_tracker.games
    assert_instance_of Games, @stat_tracker.games[0]
    assert_equal './data/teams.csv', @stat_tracker.teams_path
    assert_equal './data/game_teams_dummy.csv', @stat_tracker.game_teams_path
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.43, @stat_tracker.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    assert_equal 0.48, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.09, @stat_tracker.percentage_ties
  end

  def test_it_can_count_games_by_season
    assert_equal ({20122013 => 4, 20142015 => 11, 20152016 => 1, 20172018 => 7}), @stat_tracker.count_of_games_by_season
  end

  def test_it_calculate_average_goals_per_game
    assert_equal 4.17, @stat_tracker.average_goals_per_game
  end

  def test_it_calculate_average_goals_per_season
    assert_equal ({20122013 => 4.5, 20142015 => 4.06, 20152016 => 3.0, 20172018 => 4.27}), @stat_tracker.average_goals_by_season
  end
end
