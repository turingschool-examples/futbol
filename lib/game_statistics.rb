require 'pry'
class GameStatistics

  def initialize(games_hash)
    @games_hash = games_hash
  end

  def highest_total_score
    total_scores.max
  end

  def total_scores
    index = 0
    acc = []
    @games_hash["away_goals"].size.times do
      acc << @games_hash["away_goals"][index] + @games_hash["away_goals"][index]
    end
  end
end
