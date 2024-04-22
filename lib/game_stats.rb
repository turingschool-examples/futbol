
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

    def count_of_games_by_season  # main method
        games_per_season = Hash.new(0)
        @games.each do |game|
            games_per_season[game.season_id] += 1 # increments value of hash with season ID as key where hash in the number of games in season
        end
        games_per_season
    end

    def average_goals_per_game # main method
        all_goals = []
        @games.each do |game|
            all_goals << game.away_goals.to_f + game.home_goals.to_f # shovels home goals and away goals into array after iterating through each game
        end
        average_of_games = all_goals.sum / all_goals.size # takes average using string operators
        average_of_games.round(2)
    end
    
    def average_goals_by_season # main method
        average_goals_per_season = {}
        season_count = Hash.new(0)
        
        @games.each do |game|
            season_id = game.season_id # sets variable equal to the season ID
            season_count[season_id] += 1 # upon iteration sets the value of the season_id Key to plus one during each iteration
            average_goals_per_season[season_id] ||= 0 # equivilant to conditional say if average_goals_per_season speciifc key is = to nil, then set equal to zero using ||=0 operator.
            average_goals_per_season[season_id] += (game.away_goals.to_f + game.home_goals.to_f) # takes the average goal per season hash 
        end
        
        average_goals_per_season.each do |season_id, total_goals|
            average_goals_per_season[season_id] = (total_goals / season_count[season_id]).round(2) # takes average per the season iterating through hash using season ID for key in iteration and the total goals as the value 
        end
        
        average_goals_per_season
    end

end