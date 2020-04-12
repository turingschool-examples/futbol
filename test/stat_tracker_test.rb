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

  def test_it_returns_average_goals_per_game
      assert_equal 4.4, @stat_tracker.average_goals_per_game
  end

  def test_it_returns_average_goals_by_season
    Game.all.stubs(:map).returns([20122013, 20162017])
    Game.stubs(:average_goals).returns([3.33, 2.5])
    expected = {20122013 => 3.33, 20162017 => 2.5}
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_highest_scoring_visitor
    #team_ids
    Game.all.stubs(:map).returns([1, 2, 3, 4])
    #away_goals
    Game.stubs(:goals_per).returns([80, 60, 40, 20])
    #games
    Game.stubs(:games_per).returns([10, 10, 10, 10])
    #highest_scoring_visitor_team
    assert_equal "Atlanta United", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    #team_ids
    Game.all.stubs(:map).returns([1, 2, 3, 4])
    #home_goals
    Game.stubs(:goals_per).returns([10, 60, 40, 20])
    #games
    Game.stubs(:games_per).returns([10, 10, 10, 10])
    #highest_scoring_home_team
    assert_equal "Seattle Sounders FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    #team_ids
    Game.all.stubs(:map).returns([1, 2, 3, 4])
    #home_goals
    Game.stubs(:goals_per).returns([100, 60, 40, 20])
    #games
    Game.stubs(:games_per).returns([10, 10, 10, 10])
    #lowest_scoring_visitor_team_
    assert_equal "Chicago Fire", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    #team_ids
    Game.all.stubs(:map).returns([1, 2, 3, 4])
    #home_goals
    Game.stubs(:goals_per).returns([100, 60, 10, 20])
    #games
    Game.stubs(:games_per).returns([10, 10, 10, 10])
    #lowest_scoring_visitor_team_
    assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
  end

  def test_best_season
    assert_equal "In the 20142015 season Team 3 won 100% of games", @stat_tracker.best_season(3)
    assert_equal "In the 20122013 season Team 6 won 100% of games", @stat_tracker.best_season(6)
    assert_equal "In the 20162017 season Team 20 won 0% of games", @stat_tracker.best_season(20)
    stub_val = {
                20122013 => 25,
                20132014 => 66,
                20142015 => 44,
                20152016 => 35,
                }
    Game.stubs(:percent_by_season).returns(stub_val)
    assert_equal "In the 20132014 season Team 3 won 66% of games", @stat_tracker.best_season(3)
  end

  def test_worst_season
    assert_equal "In the 20122013 season Team 3 won 0% of games", @stat_tracker.worst_season(3)
    assert_equal "In the 20122013 season Team 6 won 100% of games", @stat_tracker.worst_season(6)
    assert_equal "In the 20162017 season Team 20 won 0% of games", @stat_tracker.worst_season(20)
    stub_val = {
                20122013 => 25,
                20132014 => 66,
                20142015 => 44,
                20152016 => 35,
                }
    Game.stubs(:percent_by_season).returns(stub_val)
    assert_equal "In the 20122013 season Team 3 won 25% of games", @stat_tracker.worst_season(3)
  end

  def test_favorite_opponent
    assert_equal "Houston Dynamo", @stat_tracker.favorite_opponent(6)
  end

end
