require "CSV"

class StatTracker

	attr_reader :games, :teams, :game_teams

	def initialize(locations)
		@locations = locations
		@games = CSV.read(locations[:games])
    @teams = CSV.read(locations[:teams])
		@game_teams = CSV.read(locations[:game_teams])
	end

	def self.from_csv(locations)
		self.new(locations)
	end

	# def create_teams(@locations[:teams])

end
