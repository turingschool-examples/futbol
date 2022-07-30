require 'pry'

class SeasonStatistics 
    def initialize(data)
        @data = data
    end

    def season_game_id_verification 
        @data[:games].all? do |row|
            row[:game_id][0, 4] == row[:season][0, 4]
        end
    end

		def winningest_coach(season)
			season_data = @data[:game_teams].select do |row|
				row[:game_id][0, 4] == season[0, 4]
			end
			coaches_total_games = Hash.new(0)
				season_data.each do |row|
					coaches_total_games[row[:head_coach]] += 1
				end

			# 	coaches_wins = Hash.new(0)
			# 	season_data.each do |row|
			# 		if (row[:result] = "WIN")
			# 		coaches_wins[row[:head_coach]] += 1 
			# 	end
			# end
			# 		binding.pry
					#not returning coaches wins, only returning total games played. 

					#turn into test
			# laviolette = season_data.select do |row|
			# 	row[:head_coach] == "Peter Laviolette"
			# end
				
		end

    
end

