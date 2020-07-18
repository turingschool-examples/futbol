require 'pry'
class GameStatistics

  def initialize(games_hash)
    @games_hash = games_hash
  end

  def highest_total_score
    index = 0
    acc -[]
    @games_hash["away_goals"].size.times do
      acc << @games_hash["away_goals"][index] + @games_hash["away_goals"][index]
    require "pry"; binding.pry
    end
  end
end
