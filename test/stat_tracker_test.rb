require 'simplecov'
SimpleCov.start
require './lib/game'
require './lib/team'
require './lib/game_team'
require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_stats'
require './lib/league_stats'
require 'pry'

class StatTrackerTest < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({
      games: './fixtures/games_fixture.csv',
      teams: './fixtures/teams_fixture.csv',
      game_teams: './fixtures/game_teams_fixture.csv'
    })
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end
#game stats
  def test_it_can_get_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_can_get_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_get_percentage_home_wins
    assert_equal 0.68, @stat_tracker.percentage_home_wins
  end

  def test_it_can_get_percentage_visitor_wins
    assert_equal 0.3, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_get_percentage_ties
    assert_equal 0.03, @stat_tracker.percentage_ties
  end

  def test_it_can_get_count_of_games_by_season
    #we need to get a better sampling if we use the fixture files
    expected = {"20122013"=>37}
    # expected = {
    #   "20122013"=>806,
    #   "20162017"=>1317,
    #   "20142015"=>1319,
    #   "20152016"=>1321,
    #   "20132014"=>1323,
    #   "20172018"=>1355
    # }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_get_average_goals_per_game
    assert_equal 3.81, @stat_tracker.average_goals_per_game
  end

  def test_it_can_get_average_goals_by_season
    expected = {"20122013"=>3.81}
    # expected = {
    #   "20122013"=>4.12,
    #   "20162017"=>4.23,
    #   "20142015"=>4.14,
    #   "20152016"=>4.16,
    #   "20132014"=>4.19,
    #   "20172018"=>4.44
    # }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
  #league stats
  def test_it_an_count_number_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "New York City FC", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Sporting Kansas City", @stat_tracker.worst_offense
  end

  def test_can_get_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_losest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "New York City FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_home_team
  end
  #season stats tests
  def test_it_can_gather_season_games
    assert_equal 74, @stat_tracker.gather_season_games("20122013").count
  end

  def test_it_can_group_season_wins_by_coach
    expected = {"John Tortorella"=>0,
                "Claude Julien"=>9,
                "Dan Bylsma"=>0,
                "Mike Babcock"=>6,
                "Joel Quenneville"=>7,
                "Paul MacLean"=>3,
                "Michel Therrien"=>1,
                "Mike Yeo"=>1,
                "Darryl Sutter"=>3,
                "Ken Hitchcock"=>3,
                "Bruce Boudreau"=>3}
    assert_equal expected, @stat_tracker.group_season_wins_by_coach("20122013")
  end

  def test_cognizant_of_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_it_can_get_worst_coach
    assert_equal "John Tortorella", @stat_tracker.worst_coach("20122013")
  end

  def test_it_can_get_most_accurate_team
    assert_equal "New York City FC", @stat_tracker.most_accurate_team("20122013")
  end

  def test_it_can_get_least_accurate_team
    assert_equal "Sporting Kansas City", @stat_tracker.least_accurate_team("20122013")
  end

  def test_it_can_get_most_tackles
    assert_equal "LA Galaxy", @stat_tracker.most_tackles("20122013")
  end

  def test_it_knows_fewest_tackles
    assert_equal "Sporting Kansas City", @stat_tracker.fewest_tackles("20122013")
  end
  # team stats tests

  def test_it_can_get_team_info
    expected = {"team_id"=>"17",
                "franchise_id"=>"12",
                "team_name"=>"LA Galaxy",
                "abbreviation"=>"LA",
                "link"=>"/api/v1/teams/17"}

    assert_equal expected, @stat_tracker.team_info("17")
  end

  def test_it_can_get_best_season
    assert_equal "20122013", @stat_tracker.best_season("6")
  end

  def test_it_can_get_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("6")
  end

  def test_it_can_get_average_win_percentage
    assert_equal 1.0, @stat_tracker.average_win_percentage("6")
  end

  def test_it_can_most_goals_scored
    assert_equal 3, @stat_tracker.most_goals_scored("17")
  end

  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("17")
  end

  def test_it_can_get_favorite_opponent
    assert_equal "New England Revolution", @stat_tracker.favorite_opponent("17")
  end

  def test_it_can_get_rival
    assert_equal "Real Salt Lake", @stat_tracker.rival("17")
  end
end
