module GameSearchable
  def highest_total_score
    Game.all.max_by {|game| game.total_score}.total_score
  end

  def lowest_total_score
		Game.all.min_by {|game| game.total_score}.total_score
  end

  def biggest_blowout
		Game.all.max_by {|game| game.score_difference}.score_difference
  end

	def percentage_home_wins
		home_wins = Game.all.find_all { |game| game.home_goals > game.away_goals }
		return ((home_wins.length.to_f/Game.all.length)).round(2)
	end

	def percentage_visitor_wins
		away_wins = Game.all.find_all { |game| game.away_goals > game.home_goals }
		return ((away_wins.length.to_f/Game.all.length)).round(2)
	end

	def percentage_ties
		ties = Game.all.find_all { |game| game.winner == nil }
		return ((ties.length.to_f/Game.all.length)).round(2)
	end

	def average_goals_per_game
		total_goals = Game.all.map {|game| game.total_score}
		return ((total_goals.sum.to_f / Game.all.length).round(2))
	end
end