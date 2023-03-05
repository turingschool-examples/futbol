require_relative 'stat_data'

class GameStats < StatData

  def self.highest_total_score
   all_games.map do |game|
      game.total_score
    end.max
  end

  def self.lowest_total_score
    all_games.map do |game|
      game.total_score
    end.min
  end
end
