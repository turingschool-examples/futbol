require './lib/modules'

class GameStats
	include Sort

	attr_reader :games

	def initialize(games)
		@games = games
	end

	def games_by_season(season)
		sort_objects_by(@games, :season)[season]
	end
end