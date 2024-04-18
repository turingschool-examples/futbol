



module GameStats

	def highest_total_score
		all_scores.sort.pop
	end

	def lowest_total_score
		all_scores.sort.shift
	end

	def all_scores # helper
		@games.map do |game|
			game.away_goals.to_i + game.home_goals.to_i
		end
	end

	def away_winners # helper
		@away_wins = []
			@games.each do |game|
				if game.away_goals.to_i > game.home_goals.to_i	
					@away_wins << game.away_goals.to_i
				end
			end
		@away_wins.sum
	end	

	def percentage_home_wins(season) # float
		home_winners(season)
		games_float = @games.count.to_f
		wins_float = @home_wins.count.to_f
		home_wins_percentage = wins_float / games_float
		home_wins_percentage.round(2) 
	end

	def percentage_visitor_wins(season) # float
		away_winners(season)
		games_float = @games.count.to_f
		wins_float = @away_wins.count.to_f
		home_wins_percentage = wins_float / games_float
		home_wins_percentage.round(2) 
	end

	def percentage_ties(season) # float
		tie_games(season)
		games_float = @games.count.to_f
		ties_float = @tie_games.count.to_f
		tie_game_percentage = ties_float / games_float
		tie_game_percentage.round(2)
		# require 'pry'; binding.pry
	end

	def tie_games(season) # helper
		@tie_games = []	
		@games.each do |game|
			if game.away_goals.to_i == game.home_goals.to_i	
				@tie_games << game
			end
		end
		@tie_games
	end

	def count_of_games_by_season(season) # hash

	end

	def average_goals_per_game(game_id) # float

	end

	def average_goals_by_season(season) # hash

	end

end