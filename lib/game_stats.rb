require './lib/stattracker'

class GameStats < StatTracker
  attr_reader :games

  def initialize(games)
    @games = games
  end

  def highest_total_score
    @games.max_by do |game|
      return game.away_goals + game.home_goals
    end
  end

  def lowest_total_score
    @games.min_by do |game|
      game.away_goals + game.home_goals
    end
  end
end
