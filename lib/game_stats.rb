require './lib/stattracker'

class GameStats < StatTracker
  attr_reader :games

  def initialize(games)
    @games = games
  end

  def highest_total_score
    top_score = @games.map do |game|
      game.away_goals + game.home_goals
    end
    top_score.max
  end

  def lowest_total_score
    bottom_score= @games.map do |game|
      game.away_goals + game.home_goals
    end
    bottom_score.min
  end
end
