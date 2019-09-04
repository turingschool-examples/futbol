require 'csv'
require_relative './game'

class StatTracker

  def initialize(games)
    @games = games
  end

  def self.from_csv(locations)
    games = []
    CSV.foreach(locations[:games], :headers=> true) do |row|
      games.push(Game.new(row))
    end
    StatTracker.new(games)
  end

  def highest_total_score
    sum = 0
    @games.each do |game|
      new_sum = game.away_goals + game.home_goals
      sum = new_sum if new_sum > sum
    end
    sum
  end
end
