require 'csv'
require_relative './game'

class GameStats

  attr_reader :games
  def initialize(games)
    @games = games
  end

  def self.from_csv(location)
    games = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    games_as_objects = games.map { |row| Game.new(row) }
    GameStats.new(games_as_objects)
  end

  def highest_total_score
    @games.map { |game| [game.home_goals.to_i, game.away_goals.to_i].sum }.max
  end

  def lowest_total_score
    @games.map { |game| [game.home_goals.to_i, game.away_goals.to_i].sum }.min
  end

  def percentage_home_wins
    ((@games.find_all { |game| game.home_goals.to_i > game.away_goals.to_i }.size) / (games.size).to_f).round(2)
  end

  def percentage_visitor_wins
    ((@games.find_all { |game| game.home_goals.to_i < game.away_goals.to_i }.size.to_f) / (games.size)).round(2)
  end

  def percentage_ties
    ((@games.find_all { |game| game.home_goals.to_i == game.away_goals.to_i }.size.to_f) / (games.size)).round(2)
  end

  def count_of_games_by_season
    game_count = Hash.new(0)
    @games.each { |game| game_count[game.season] += 1 } 
    game_count
  end

  def average_goals_per_game
    total_goals_per_game = []
    @games.map { |game| total_goals_per_game << [game.home_goals.to_i, game.away_goals.to_i].sum }
    ((total_goals_per_game.sum.to_f) / (@games.size)).round(2)
  end
end