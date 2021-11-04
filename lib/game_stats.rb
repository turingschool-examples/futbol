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

  def highest_total_score
    @games.map do |game|
      (game.away_goals.to_i + game.home_goals.to_i)
    end.max
  end

  def lowest_total_score
    @games.map do |game|
      (game.away_goals.to_i + game.home_goals.to_i)
    end.min
  end

  def percentage_home_wins
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

  def percentage_visitor_wins
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

  def percentage_ties
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
end
