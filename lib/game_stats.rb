require 'csv'
require_relative "game.rb"

class GameStats < Game
    attr_reader :games

    def initialize(file)
      @games = self.format(file)
    end

  def format(file)
    game_file = CSV.read(file, headers: true, header_converters: :symbol)
    game_file.map do |row|
      Game.new(row)
    end
  end

  def highest_total_score   #returns highest number of goals in any game
    @games.map do |game|
      (game.away_goals.to_i + game.home_goals.to_i)
    end.max
  end

  def lowest_total_score  #returns lowest number of goals scored in any game
    @games.map do |game|
      (game.away_goals.to_i + game.home_goals.to_i)
    end.min
  end

  def percentage_home_wins #returns a float percentage of home team wins of all games
    total_games = 0
    @games.each do |game|
      total_games += 1
    end

    total_home_wins = 0
    @games.each do |game|
      if game.home_goals > game.away_goals
        total_home_wins += 1
      end
    end
    (total_home_wins.to_f / total_games).round(2)
  end

  def percentage_visitor_wins # returns a float percentage of away team wins of all games
    total_games = 0
    @games.each do |game|
      total_games += 1
    end

    total_visitor_wins = 0
    @games.each do |game|
      if game.away_goals > game.home_goals
        total_visitor_wins += 1
      end
    end
    (total_visitor_wins.to_f / total_games).round(2)
  end

  def percentage_ties #returns a float percentage of tie games
    total_games = 0
    @games.each do |game|
      total_games += 1
    end

    total_ties = 0
    @games.each do |game|
      if game.away_goals == game.home_goals
        total_ties += 1
      end
    end
    (total_ties.to_f / total_games).round(2)
  end

  def count_of_games_by_season #returns a hash
    values = @games.map do |game|
      game.season
    end
    hash = Hash.new(0)
    values.each { | value | hash.store(value, hash[value]+1) }
    hash
  end

  def average_goals_per_game
    total_goals = 0
    @games.each do |game|
      total_goals += (game.home_goals.to_i + game.away_goals.to_i)
    end
    (total_goals.to_f / @games.count).round(2)
  end

  def average_goals_per_season(season) #helper method for method below
    total_goals = 0
    total_games = []
    @games.each do |game|
      if game.season == season
        total_goals += (game.home_goals.to_i + game.away_goals.to_i)
        total_games << game
      end
    end
    (total_goals/total_games.count.to_f).round(2)
  end

  def average_goals_by_season
    seasons = @games.map do |game|
      game.season
    end
    hash = Hash.new(0)
    seasons.each { | season | hash.store(season, average_goals_per_season(season)) }
    hash
  end
end
