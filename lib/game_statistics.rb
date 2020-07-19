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

  def lowest_total_score
    total_goals.min
  end

  def count_games_by_season
    games_by_season = {}
    @games_hash["season"].each do |season|
      if games_by_season[season] == nil
        games_by_season[season] = 1
      else
        games_by_season[season] += 1
      end
    end
    games_by_season
  end

  def average_goals_per_game
    (total_goals.sum.to_f / data_size).round(2)
  end

end
