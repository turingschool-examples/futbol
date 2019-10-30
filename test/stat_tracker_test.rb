require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './dummy_data/dummy_games.csv'
    team_path = './dummy_data/dummy_teams.csv'
    game_teams_path = './dummy_data/dummy_game_teams.csv'
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

  def test_it_initializes
    assert_equal './dummy_data/dummy_games.csv', @stat_tracker.game_path
    assert_equal './dummy_data/dummy_game_teams.csv', @stat_tracker.game_teams_path
    assert_equal './dummy_data/dummy_teams.csv', @stat_tracker.team_path
  end

  def test_it_can_create_games
      assert_instance_of GameCollection, @stat_tracker.game
  end

  def test_it_can_create_game_teams
    assert_instance_of GameTeamsCollection, @stat_tracker.game_teams
  end

  def test_it_can_create_teams
    assert_instance_of TeamCollection, @stat_tracker.team
  end

  def test_it_can_get_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_can_count_of_games_by_season
    assert_equal Hash, @stat_tracker.count_of_games_by_season.class
    assert_equal 4, @stat_tracker.count_of_games_by_season.count
  end

  def test_lowest_total_score
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_average_goals_per_game
    assert_equal 4.0, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal 4.0, @stat_tracker.average_goals_by_season["20122013"]
    expected_value = {"20122013"=>4.0, "20152016"=>4.33, "20162017"=>4.0, "20172018"=>3.0}
    assert_equal expected_value,  @stat_tracker.average_goals_by_season
  end

  def test_percentage_visitor_wins
    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_home_wins
    assert_equal 0.53, @stat_tracker.percentage_home_wins
  end

  def test_percentage_ties
    assert_equal 0.13, @stat_tracker.percentage_ties
  end

  def test_count_of_teams
    assert_equal 16, @stat_tracker.count_of_teams
  end

  def test_winningest_team
    assert_equal "Houston Dynamo", @stat_tracker.winningest_team
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "DC United", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Toronto FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_home_team
  end

  def test_worst_fans
    assert_equal ["Sporting Kansas City"], @stat_tracker.worst_fans
  end
end
