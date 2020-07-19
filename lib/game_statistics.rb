require 'pry'
class GameStatistics

  def initialize(games_hash)
    @games_hash = games_hash
  end

  def data_size
    @games_hash["game_id"].size
  end

  def total_scores
    index = 0
    acc = []
    data_size.times do
      acc << @games_hash["away_goals"][index].to_i + @games_hash["home_goals"][index].to_i
      index += 1
    end
    acc
  end

  def highest_total_score
    total_scores.max
  end

end
