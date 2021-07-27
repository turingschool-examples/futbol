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
    bottom_score = @games.map do |game|
      game.away_goals + game.home_goals
    end
    bottom_score.min
  end

  def percentage_home_wins
    hwins = []
    @games.map do |game|
      if game.home_goals > game.away_goals
        hwins << game
      end
    end
    (hwins.length.to_f / @games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    awins = []
    @games.map do |game|
      if game.away_goals > game.home_goals
        awins << game
      end
    end
    (awins.length.to_f / @games.length.to_f).round(2)
  end

  def percentage_ties
    ties = []
    @games.map do |game|
      if game.away_goals == game.home_goals
        ties << game
      end
    end
    (ties.length.to_f / @games.length.to_f).round(2)
  end
end
