require_relative 'stats'

class GameStatistics < Stats
  def initialize(locations)
    super
  end

  def percentage_home_wins
    home_wins = 0
    @games.each do |game|
      home_wins += 1 if game.home_goals > game.away_goals
    end
    (home_wins.to_f / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @games.each do |game|
      visitor_wins += 1 if game.home_goals < game.away_goals
    end
    (visitor_wins.to_f / @games.count.to_f).round(2)
  end

  def percentage_ties
    ties = 0
    @games.each do |game|
      ties += 1 if game.home_goals == game.away_goals
    end
    percentage = (ties.to_f / @games.count.to_f).round(2)
  end
end