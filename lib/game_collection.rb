require_relative '../lib/game'

class GameCollection
	attr_reader :games_array

	def initialize(location)
		@games_array = []
		CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
			@games_array << Game.new(row)
		end
	end

	def total_score
    total_score = @games_array.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
  end
end