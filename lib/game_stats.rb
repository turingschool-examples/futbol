require_relative 'stat_data'

class GameStats < StatData

  def initialize(locations)
    super(locations)
  end

  def highest_total_score
    # super(all_games)
   all_games.map do |game|
      game.total_score
    end.max
  end

  def lowest_total_score
    all_games.map do |game|
      game.total_score
    end.min
  end
end
