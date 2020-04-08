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

  def test_highest_scoring_visitor
    #team_ids
    Game.all.stubs(:map).returns([1, 2, 3, 4])
    #away_goals
    Game.stubs(:goals_per).returns([80, 60, 40, 20])
    #games
    Game.stubs(:games_per).returns([10, 10, 10, 10])
    #highest_scoring_visitor_team_id
    assert_equal "Atlanta United", @stat_tracker.highest_scoring_visitor
  end


  # def test_highest_scoring_visitor
  #   #team_ids
  #   Game.all.stubs(:map).returns([1, 2, 3, 4])
  #   #away_goals
  #   Game.stubs(:goals_per).returns([80, 60, 40, 20])
  #   #games
  #   Game.stubs(:games_per).returns([10, 10, 10, 10])
  #
  #   #highest_scoring_visitor_team_id
  #   assert_equal 1, Game.nth_scoring_team_id(:max_by, :away_team_id, :away_goals)
  #   #lowest_scoring_visitor_team_id
  #   assert_equal 4, Game.nth_scoring_team_id(:min_by, :away_team_id, :away_goals)
  #
  #   #home_goals
  #   Game.stubs(:goals_per).returns([60, 80, 20, 40])
  #   #games
  #   Game.stubs(:games_per).returns([10, 10, 10, 10])
  #   #highest_scoring_home_team_id
  #   assert_equal 2, Game.nth_scoring_team_id(:max_by, :away_team_id, :home_goals)
  #   #lowest_scoring_home_team_id
  #   assert_equal 3, Game.nth_scoring_team_id(:min_by, :away_team_id, :home_goals)
  # end


end
