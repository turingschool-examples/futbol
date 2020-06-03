require 'csv'
require_relative 'test_helper'
require './lib/stat_tracker'
require './lib/game'

class StatTrackerTest < MiniTest::Test

  def setup
    @game_path = "./data/games.csv"
    @team_path = "./data/teams.csv"
    @game_teams_path = "./data/game_teams.csv"
    @locations = {
                  games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path
                  }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_has_csv_files
    assert_instance_of Array, @stat_tracker.games_collection.games_array
    assert_instance_of Game, @stat_tracker.games_collection.games_array[0]
    assert_instance_of Array, @stat_tracker.teams_collection.teams_array
    assert_instance_of Team, @stat_tracker.teams_collection.teams_array[0]
    assert_instance_of Array, @stat_tracker.game_teams_collection.game_teams_array
    assert_instance_of GameTeams, @stat_tracker.game_teams_collection.game_teams_array[0]
  end

  def test_it_is_an_instance
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_it_has_percentage_home_wins
    assert_equal 43.5, @stat_tracker.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 36.11, @stat_tracker.percentage_visitor_wins
  end

  def test_it_has_percentage_ties
    assert_equal 20.39, @stat_tracker.percentage_ties
  end

  def test_it_finds_count_of_games_by_season
    @stat_tracker.expects(:count_of_games_by_season).returns({"20122013"=>3, "20142015"=>4})
    assert_equal ({"20122013"=>3, "20142015"=>4}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_find_average_goals_per_game
    assert_equal 2.11, @stat_tracker.average_goals_per_game
  end

  def test_has_average_goals_by_season
    @stat_tracker.expects(:average_goals_by_season).returns({"20122013"=>3, "20142015"=>4})
    assert_equal ({"20122013"=>3, "20142015"=>4}), @stat_tracker.average_goals_by_season
  end

  def test_it_counts_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_finds_best_offense
    assert_equal "Sporting Kansas City", @stat_tracker.best_offense
  end

  def test_it_finds_worst_offense
      assert_equal "Reign FC", @stat_tracker.worst_offense
  end

  def test_it_finds_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_it_finds_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  # def test_it_finds_lowest_scoring_vister
  #
  # end

  # def test_it_finds_lowest_scoring_home_team

  # end

  def test_it_finds_a_winningest_coach
    season_id = "20122013"
    assert_equal "Dan Lacroix", @stat_tracker.winningest_coach(season_id)
  end

  def test_it_finds_worst_coach
    season_id = "20122013"
    assert_equal "Martin Raymond", @stat_tracker.worst_coach(season_id)
  end

  def test_it_finds_most_accurate_team
    assert_equal "Washington Spirit FC", @stat_tracker.most_accurate_team("20122013")
  end

  def test_it_finds_least_accurate_team
    assert_equal "Sporting Kansas City", @stat_tracker.least_accurate_team("20122013")
  end

  def test_it_finds_team_with_most_tackles
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20122013")
  end

  def test_it_finds_team_with_least_tackles
    assert_equal "Atlanta United", @stat_tracker.least_tackles("20122013")
  end
end


  # def test_it_finds_favorite_opponent
  #   assert_equal "FC Dallas", @stat_tracker.favorite_opponent(8)
  # end
  #
  # def test_it_finds_rival
  #   assert_equal "FC Dallas", @stat_tracker.rival(8)
  # end
