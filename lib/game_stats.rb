module GameStats




  def lowest_total_score
    @games.map {|game| game.total_scores_per_game}.min
  end

  def highest_total_score
    @games.map {|game| game.total_scores_per_game}.max
  end
end
