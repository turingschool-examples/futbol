require_relative 'test_helper'
require 'csv'
require './lib/games_methods'

class GameStatsTest < Minitest::Test
  def setup
    @games = Games.new("./data/games_truncated.csv")
    @game = @games.games.first
  end

  def test_it_exists
    assert_instance_of Games, @games
  end

  def test_it_has_attributes
    assert_instance_of Array, @games.games
    assert_equal 59, @games.games.length
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Games, @games
    assert_equal "3", @game.away_team_id
    assert_equal "2012030221", @game.game_id
  end
end

# Method	Description	Return Value
### highest_total_score	###Highest sum of the winning and losing teams’ scores	Integer
### lowest_total_score ###	Lowest sum of the winning and losing teams’ scores	Integer
### percentage_home_wins ###	Percentage of games that a home team has won
# (rounded to the nearest 100th)	Float
### percentage_visitor_wins ### Percentage of games that a visitor has won
# (rounded to the nearest 100th)	Float
### percentage_ties	### Percentage of games that has resulted in a tie
# (rounded to the nearest 100th)	Float
### count_of_games_by_season ###	A hash with season names (e.g. 20122013)
# as keys and counts of games as values	Hash
### average_goals_per_game ###	Average number of goals scored in a game across all
# seasons including both home and away goals (rounded to the nearest 100th)	Float
### average_goals_by_season	### Average number of goals scored in a game organized
# in a hash with season names (e.g. 20122013) as keys and a float representing
#the average number of goals in a game for that season as a key (rounded to the nearest 100th)
