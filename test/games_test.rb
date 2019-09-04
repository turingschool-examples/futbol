require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/games'

class GamesTest < Minitest::Test

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

  end

  #Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)	Float
  #AM
  def test_average_goals_per_game

  end

  #Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the #average number of goals in a game for that season as a key (rounded to the nearest 100th)	Hash
  #AM
  def test_average_goals_by_season

  end

end
