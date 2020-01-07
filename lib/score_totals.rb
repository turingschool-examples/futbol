require_relative 'game'
require 'csv'

class ScoreTotals
  # @@all_games

  def self.highest_score_total
    total_goals = Game.all_games.map {|game| game.away_goals + game.home_goals}
    total_goals.max
  end

  def self.lowest_score_total
    total_goals = Game.all_games.map {|game| game.away_goals + game.home_goals}
    total_goals.min
  end

  def self.biggest_blowout

  end

end
