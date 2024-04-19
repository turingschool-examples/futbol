
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

    def count_of_games_by_season 
        games_per_season = Hash.new(0)
        @games.each do |game|
            games_per_season[game.season_id] += 1
        end
        games_per_season
    end

    def average_goals_per_game
        all_goals = []
        @games.each do |game|
            all_goals << game.away_goals.to_f + game.home_goals.to_f
        end
        average_of_games = all_goals.sum / all_goals.size
        average_of_games.round(2)
    end
    
    def average_goals_by_season
        average_goals_per_season = {}
        season_count = Hash.new(0)
        
        @games.each do |game|
            season_id = game.season_id
            season_count[season_id] += 1
            average_goals_per_season[season_id] ||= 0
            average_goals_per_season[season_id] += (game.away_goals.to_f + game.home_goals.to_f)
        end
        
        average_goals_per_season.each do |season_id, total_goals|
            average_goals_per_season[season_id] = (total_goals / season_count[season_id]).round(2)
        end
        
        average_goals_per_season
    end

end