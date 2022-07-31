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
end