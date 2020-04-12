require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_fixture.csv'

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

  def test_has_attributes

    assert_equal  './data/games_fixture.csv', @stat_tracker.games
    assert_equal  './data/teams.csv', @stat_tracker.teams
    assert_equal  './data/game_teams_fixture.csv', @stat_tracker.game_teams
  end

  def test_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_calculate_percentage_of_home_wins
    assert_equal 0.63, @stat_tracker.percentage_home_wins
  end
  #
  def test_it_can_calculate_percentage_of_visitor_game_wins
    assert_equal 0.25, @stat_tracker.percentage_visitor_wins
  end
  #
  def test_it_can_calculate_percenatage_ties
    assert_equal 0.13, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013"=>12, "20132014"=>3, "20172018"=>3, "20162017"=>3, "20152016"=>1, "20142015"=>5}), @stat_tracker.count_of_games_by_season
  end

  def test_average_number_of_goals_per_game
    assert_equal 4.11,@stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({"20122013"=>4.0, "20132014"=>4.0, "20172018"=>3.67, "20162017"=>4.33, "20152016"=>4.0, "20142015"=>4.6}), @stat_tracker.average_goals_by_season
  end

end
