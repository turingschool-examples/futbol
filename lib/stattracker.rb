require "csv"
class StatTracker
	attr_reader :game_ids
	def initialize
		contents = CSV.open './data/games_tester.csv', headers: true, header_converters: :symbol
		@game_ids = contents.map{|row| row[:game_id].to_i}
	end
	
	# def game_ids
	# end
end