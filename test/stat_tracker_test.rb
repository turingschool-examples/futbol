require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    # @locations = {
    #   games: './data/games.csv',
    #   teams: './data/teams.csv',
    #   game_teams: './data/game_teams.csv'
    # }

    @locations = {
      games: './data/dummy_games.csv',
      teams: './data/dummy_teams.csv',
      game_teams: './data/dummy_game_teams.csv'
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_initialize
    assert_instance_of Team, @stat_tracker.teams[0]
    assert_equal 20, @stat_tracker.teams.length

    assert_instance_of Game, @stat_tracker.games[0]
    assert_equal 20, @stat_tracker.games.length

    assert_instance_of GameTeam, @stat_tracker.game_teams[0]
    assert_equal 40, @stat_tracker.game_teams.length
  end


  # Game Statistics Tests

  def test_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 65.00, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 25.00, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 10.00, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>4,
                "20132014"=>4,
                "20142015"=>4,
                "20152016"=>4,
                "20162017"=>4
              }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end


end
