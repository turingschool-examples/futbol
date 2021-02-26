require './lib/game'
require './modules/data_loadable'

class GameManager
  include DataLoadable

  attr_reader :games

  def initialize(data)
    @games = load_data(data, Game)
  end

  def highest_scoring_game
    @games.max_by do |game|
      game.total_score
    end
  end

  def home_wins
    @games.find_all do |game|
      game.winner == :home
    end
  end

  def away_wins
    @games.find_all do |game|
      game.winner == :away
    end
  end

  def ties
    @games.find_all do |game|
      game.winner == :tie
    end
  end

  def calculate_percentage_home_wins
<<<<<<< HEAD:lib/game_manager.rb
    ((home_wins.count.to_f / @games.count) * 100).round(2)
  end

  def calculate_percentage_away_wins
    ((away_wins.count.to_f / @games.count) * 100).round(2)
  end

  def calculate_percentage_ties
    ((ties.count.to_f / @games.count) * 100).round(2)
  end

  def lowest_scoring_game
    @games.min_by do |game|
      game.total_score
    end
  end

  def number_of_season_games
    season_names_and_games = {}
    @games.each do |game|
      if season_names_and_games[game.season].nil?
         season_names_and_games[game.season] = 1
      else
         season_names_and_games[game.season] += 1

      end
    end
    season_names_and_games
  end

  def average_goals_per_match
    all_goals = 0
    @games.each do |game|
      all_goals += game.total_score
    end
     (all_goals.to_f / @games.count).round(2)
  end

  def average_goals_by_season
    # Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
    # Result: Hash
    # average goals per game = total goals /
    season_names_and_average_goals = {}
    average_goals_per_match 
    @games.each do |game|
      if season_names_and_average_goals[game.season].nil?
         season_names_and_average_goals[game.season] = 1
      else
         season_names_and_average_goals[game.season] += 1
      end
    end
    season_names_and_games
  end

=======
    # number of home wins / total number games
    (home_wins.count.to_f / @games.count) * 100
  end
>>>>>>> main:manager/game_manager.rb

  # def highest_total_score
  #   # Description: Highest sum of the winning and losing teams’ scores
  #   # Return Value: Integer
  # end
  #
  # def lowest_total_score
  #   # Description: Lowest sum of the winning and losing teams’ scores
  #   # Return Value: Integer
  # end
  #
  # def percentage_home_wins
  #   # Description: Percentage of games that a home team has won (rounded to the nearest 100th)
  #   # Return Value: Float
  # end
  #
  # def percentage_visitor_wins
  #   # Description: Percentage of games that a visitor has won (rounded to the nearest 100th)
  #   # Return Value: Float
  # end
  #
  # def percentage_ties
  #   # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
  #   # Return Value: Float
  # end
  #
  # def count_of_games_by_season
  #   # A hash with season names (e.g. 20122013) as keys and counts of games as values.
  #   # Return Value: Hash
  # end
  #
  # def average_goals_per_game
  #   # Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
  #   # Return Value: Float
  # end
  #
  # def average_goals_by_season
  #   # Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
  #   # Return Value: Hash
  # end
end
