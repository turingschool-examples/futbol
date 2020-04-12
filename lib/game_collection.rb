require 'csv'
require_relative 'game'

class GameCollection
  attr_reader :games_list, :pct_data

  def initialize(file_path)
    @games_list = create_games(file_path)
  end

  def create_games(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end

  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  # percentage_home_wins Percentage of games that a home team has won (rounded to the nearest 100th)Float

  def percentage_home_wins
  ((home_wins.to_f / @games_list.length.to_f) * 100).round(2)
  end

  def percentage_visitor_wins
    ((away_wins.to_f / @games_list.length.to_f) * 100).round(2)
  end

  def percentage_ties
    ((ties.to_f / @games_list.length.to_f) * 100).round(2)
  end

  def test_count_of_games_by_season

  end

  def average_goals_per_game

  end

  def test_average_goals_by_season

  end


# helper methods

def total_scores
  @games_list.map { |game| game.home_goals.to_i + game.away_goals.to_i }
end

def home_wins
  # tying to find all the home wins
  @games_list.select { |game| game.home_goals > game.away_goals}.length
end


def away_wins
  @games_list.select { |game| game.home_goals < game.away_goals}.length
end

def ties
  @games_list.select { |game| game.home_goals == game.away_goals}.length
end

























  # count_of_games_by_season A hash with season names (e.g. 20122013) as keys and counts of games as valuesHash
  #
  # average_goals_per_game Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)Float
  #
  # average_goals_by_season Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average
  #
  # number of goals in a game for that season as values (rounded to the nearest 100th)Hash




end
