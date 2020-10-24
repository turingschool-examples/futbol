class GameStatistics
  def highest_total_score(game_data)
    game_data.max_by do |index, game|
      require "pry"; binding.pry
    end
  end
end
