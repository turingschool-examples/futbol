require './test/test_helper'
require './lib/stat_tracker'
require './lib/gameable'
# require 'pry'

class GameableTest < Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end


  #Highest sum of the winning and losing teams’ scores	Integer
  #BB
  def test_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  #Lowest sum of the winning and losing teams’ scores	Integer
  #BB
  def test_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  #Highest difference between winner and loser	Integer
  #BB
  def test_biggest_blowout
    assert_equal 8, @stat_tracker.biggest_blowout
  end

  # Percentage of games that a home team has won (rounded to the nearest 100th)	Float
  # JP
  def test_percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  # Percentage of games that a visitor has won (rounded to the nearest 100th)	Float
  # JP
  def test_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end

  #Percentage of games that has resulted in a tie (rounded to the nearest 100th)	Float
  #JP
  def test_percentage_ties
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  #A hash with season names (e.g. 20122013) as keys and counts of games as values	Hash
  #AM
  def test_count_of_games_by_season

    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season

  end

  # Average number of goals scored in a game across all seasons including both home and away goals
  # (rounded to the nearest 100th)	Float
  # AM
  def test_average_goals_per_game

    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  # Average number of goals scored in a game organized in a hash with season names (e.g. 20122013)
  # as keys and a float representing the #average number of goals in a game for that season as a key
  # (rounded to the nearest 100th)	Hash
  # AM
  def test_average_goals_by_season

    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    assert_equal expected, @stat_tracker.average_goals_by_season

  end

  def test_helper_unique_seasons_array

    expected = ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"]

    assert_equal expected, @stat_tracker.unique_seasons_array_helper

  end

end
