require 'pry'
class GameStatistics

  def initialize(games_hash)
    @games_hash = games_hash
  end

  def data_size
    @games_hash["game_id"].size
  end

  def total_goals
    index = 0
    total_goals_by_game = []
    data_size.times do
      total_goals_by_game << @games_hash["away_goals"][index].to_i + @games_hash["home_goals"][index].to_i
      index += 1
    end
    total_goals_by_game
  end

  def highest_total_score
    total_goals.max
  end

  def percentage_home_wins
      
  end

end
