require_relative 'stats'

class GameStatistics < Stats
  def initialize(locations)
    super
  end

  def percentage_home_wins
    home_win_count = 0
    @games.each do |game|
      require 'pry'; binding.pry
      if game.home_goals > game.away_goals
        home_win_count += 1
      end
    end
    (home_win_count.to_f / @games.count.to_f) * 100
  end
end