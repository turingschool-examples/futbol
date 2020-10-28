require_relative './test_helper'
require 'csv'

class StatTrackerTest < MiniTest::Test

  def setup
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

# Game Statistics Methods
  def test_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

# League Statistics Methods
  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_team_with_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_team_with_worst_offense
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  #below assertions are not using fixture files
  #team statistics
  def test_can_retrieve_team_info
    expected = {"team_id"=>"6", "franchise_id"=>"6", "team_name"=>"FC Dallas", "abbreviation"=>"DAL", "link"=>"/api/v1/teams/6"}
    assert_equal expected, @stat_tracker.team_info("6")
  end

  def test_retrieve_best_season_by_team
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_retrieve_worst_season_by_team
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_can_retrieve_average_win_percetange_for_all_games_for_a_team
    assert_equal 0.49, @stat_tracker.average_win_percentage("6")
  end

  def test_can_retrieve_highest_number_of_goals_from_single_game
    assert_equal 6, @stat_tracker.most_goals_scored("6")
  end

  def test_can_retrieve_fewest_number_of_goals_from_single_game
    assert_equal 0, @stat_tracker.fewest_goals_scored("6")
  end

  def test_can_check_favorite_opponent
    assert_equal "Columbus Crew SC", @stat_tracker.favorite_opponent("6")
  end

  def test_can_check_rival
    assert_equal "Real Salt Lake", @stat_tracker.rival("6")
  end
end
