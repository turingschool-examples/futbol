require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
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
    assert_equal 0.60, @stat_tracker.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.20, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_find_percentage_ties
    assert_equal 0.25, @stat_tracker.percentage_ties
  end

  def test_it_can_count_games_in_a_season
    assert_equal ({"20122013"=>2, "20162017"=>5, "20142015"=>6, "20132014"=>4, "20152016"=>2, "20172018"=>1}), @stat_tracker.count_of_games_by_season
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
  def test_it_returns_average_goals_per_game
      assert_equal 4.4, @stat_tracker.average_goals_per_game
  end

  def test_it_returns_average_goals_by_season
    stub_games_goals = {
                        "20122013" => {:goals => 10, :games_played => 3},
                        "20162017" => {:goals => 10, :games_played => 4}
                        }
    Game.stubs(:games_goals_by_season).returns(stub_games_goals)
    expected = {"20122013" => 3.33, "20162017" => 2.5}
    assert_equal expected, Game.average_goals_by_season
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_highest_scoring_visitor
    assert_equal "16", Game.highest_scoring_visitor_team_id
    games_goals = {"1" => {:goals => 11, :games_played =>2},
                   "2" => {:goals => 2, :games_played =>1},
                   "3" => {:goals => 3, :games_played =>1}}
    stub_expected = Game.divide_hash_values(:goals, :games_played, games_goals)
    Game.stubs(:average_goals_by).returns(stub_expected)
    assert_equal "1", Game.highest_scoring_visitor_team_id
    assert_equal "Atlanta United", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "6", Game.highest_scoring_home_team_id
    games_goals = {"1" => {:goals => 1, :games_played =>2},
                   "2" => {:goals => 12, :games_played =>1},
                   "3" => {:goals => 3, :games_played =>1}}
    stub_expected = Game.divide_hash_values(:goals, :games_played, games_goals)
    Game.stubs(:average_goals_by).returns(stub_expected)
    assert_equal "2", Game.highest_scoring_home_team_id
    #highest_scoring_home_team
    assert_equal "Seattle Sounders FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "9", Game.lowest_scoring_visitor_team_id
    games_goals = {"1" => {:goals => 4, :games_played =>2},
                   "2" => {:goals => 12, :games_played =>10},
                   "3" => {:goals => 3, :games_played =>1}}
    stub_expected = Game.divide_hash_values(:goals, :games_played, games_goals)
    Game.stubs(:average_goals_by).returns(stub_expected)
    assert_equal "2", Game.lowest_scoring_visitor_team_id
      #lowest_scoring_visitor_team_
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "5", Game.lowest_scoring_home_team_id
    games_goals = {"1" => {:goals => 5, :games_played =>2},
                   "2" => {:goals => 12, :games_played =>1},
                   "3" => {:goals => 4, :games_played =>3}}
    stub_expected = Game.divide_hash_values(:goals, :games_played, games_goals)
    Game.stubs(:average_goals_by).returns(stub_expected)
    assert_equal "3", Game.lowest_scoring_home_team_id
    #lowest_scoring_home_team_
    assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_home_team
  end



  def test_best_season
    assert_equal "20142015", @stat_tracker.best_season("3")
    assert_equal "20122013", @stat_tracker.best_season("6")
    assert_equal "20162017", @stat_tracker.best_season("20")
    stub_val = {
                "20122013" => 25,
                "20132014" => 66,
                "20142015" => 44,
                "20152016" => 35,
                }
    Game.stubs(:win_percent_by_season).returns(stub_val)
    assert_equal "20132014", @stat_tracker.best_season("3")
  end

  def test_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("3")
    assert_equal "20122013", @stat_tracker.worst_season("6")
    assert_equal "20162017", @stat_tracker.worst_season("20")
    stub_val = {
                "20122013" => 25,
                "20132014" => 66,
                "20142015" => 44,
                "20152016" => 35,
                }
    Game.stubs(:win_percent_by_season).returns(stub_val)
    assert_equal "20122013", @stat_tracker.worst_season("3")
  end

  def test_most_accurate_team
    assert_equal "Houston Dynamo", @stat_tracker.most_accurate_team(20122013)
  end

  def test_least_accurate_team
    assert_equal "FC Dallas", @stat_tracker.least_accurate_team(20122013)
  end

  def test_most_goals_scored_by_team_id
    assert_equal 2, @stat_tracker.most_goals_scored(3)
  end

  def test_least_goals_scored_by_team_id
    assert_equal 2, @stat_tracker.fewest_goals_scored(26)
  end

  def test_it_returns_best_offence
    assert_equal "Los Angeles FC", @stat_tracker.best_offense
  end

  def test_it_returns_worst_offence
    assert_equal "Portland Timbers", @stat_tracker.worst_offense
  end

  def test_favorite_opponent
    assert_equal "Houston Dynamo", @stat_tracker.favorite_opponent(6)
  end

  def test_rival
    assert_equal "FC Dallas", @stat_tracker.rival(3)
  end

end
