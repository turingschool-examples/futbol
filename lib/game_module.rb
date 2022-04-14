module GameModule

  def GameModule.total_score(games)
    score_arr = []
    games.each do |game|
      score_arr << game.away_goals.to_i + game.home_goals.to_i
    end
    return score_arr
  end

  def GameModule.total_home_wins(games)
		total_home_wins = []
		games.each do |game|
			if game.home_goals.to_f > game.away_goals.to_f
				total_home_wins << game
			end
		end
		return total_home_wins
  end

  def GameModule.total_visitor_wins(games)
    total_visitor_wins = []
    games.each do |game|
      if game.home_goals.to_f < game.away_goals.to_f
        total_visitor_wins << game
      end
    end
    return total_visitor_wins
  end
end
