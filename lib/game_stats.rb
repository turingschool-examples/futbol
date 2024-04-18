



module GameStats

	def highest_total_score # integer
		all_scores.sort.pop
	end

	def lowest_total_score # integer
		all_scores.sort.shift
	end

	def percentage_home_wins # float
		total_games_float = @games.count.to_f
		percentage = home_winners.to_f / total_games_float
		percentage.round(2)
	end

	def percentage_visitor_wins # float
		total_games_float = @games.count.to_f
		away_winners_float = away_winners.to_f / total_games_float
		away_winners_float.round(2)
	end

	def percentage_ties #float
		total_games_float = @games.count.to_f
		ties_float = tie_games.to_f
		tie_game_percentage = ties_float / total_games_float
		tie_game_percentage.round(2)
	end

	def all_scores # helper
		@games.map do |game|
			game.away_goals.to_i + game.home_goals.to_i
		end
	end

	def away_winners # helper
		away_wins = []
		@games.each do |game|
			if game.away_goals.to_i > game.home_goals.to_i	
				away_wins << game
			end
		end
		away_wins.count
	end	

	def home_winners # helper
		home_wins = []
		@games.each do |game|
			if game.home_goals.to_i > game.away_goals.to_i	
				home_wins << game				
			end
		end
		home_wins.count
	end	

	def tie_games # helper
		tie_games = []	
		@games.each do |game|
			if game.away_goals.to_i == game.home_goals.to_i	
				tie_games << game
			end
		end
		tie_games.count
	end

end