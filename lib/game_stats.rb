



module GameStats

	def highest_total_score(season) # integer
		if away_winners(season) > home_winners(season)
			away_winners(season)
		elsif away_winners(season) < home_winners(season)
			home_winners(season)
		end
		#   require 'pry'; binding.pry
	end

	def lowest_total_score(season)
		if away_winners(season) < home_winners(season)
			away_winners(season)
		elsif away_winners(season) > home_winners(season)
			home_winners(season)
		end
	end

	def get_games(season) # helper
		@all_games = @games
	end

	def home_winners(season) # helper
		@home_wins = []	
			@games.each do |game|
				if game.away_goals.to_i < game.home_goals.to_i	
					@home_wins << game.home_goals.to_i
				end
			end
			@home_wins.sum
	end

	def away_winners(season) # helper
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
		
		# require 'pry'; binding.pry
	end

	def percentage_visitor_wins(season) # float
		away_winners(season)
		games_float = @games.count.to_f
		wins_float = @away_wins.count.to_f
		home_wins_percentage = wins_float / games_float
		home_wins_percentage.round(2) 
		# require 'pry'; binding.pry
	end

	def percentage_ties(season) # float

	end

	def count_of_games_by_season(season) # hash

	end

	def average_goals_per_game(game_id) # float

	end

	def average_goals_by_season(season) # hash

	end

end