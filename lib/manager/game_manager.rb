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
    games_by_season.transform_values! do |array|
      avg = array.map do |game|
        game.total_score
      end.sum
      (avg.to_f / array.length).round(2)
    end
  end

  def games_by_season
    season_games = @games.reduce({}) do |hash, game|
      hash[game.season] << game if hash[game.season]
      hash[game.season] = [game] if hash[game.season].nil?
      hash
    end
    season_games
  end
end
