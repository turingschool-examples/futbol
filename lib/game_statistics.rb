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
    percentage = (home_wins.to_f / @games.count.to_f) * 100
    percentage.round(2)
  end
end