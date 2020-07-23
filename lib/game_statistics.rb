require_relative "game_data"
class GameStatistics

  def initialize
  end

  def all_games
    GameData.create_objects
  end

  def total_score
    all_games.map do |games|
      games.home_goals + games.away_goals
    end
  end

  def highest_total_score
    total_score.max
  end

  def lowest_total_score
    total_score.min
  end

end
