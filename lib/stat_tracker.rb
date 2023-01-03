require "csv"
class StatTracker
	attr_reader :game_teams,
              :games,
              :teams

	def initialize
    @game_teams = ''
    @games = ''
    @teams = ''
		# @game_ids = contents.map{|row| row[:game_id].to_i}
	end
	
	def self.from_csv(locations)
    contents = CSV.open './data/games_tester.csv', headers: true, header_converters: :symbol
    
    
	end
	# end
end