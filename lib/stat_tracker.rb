require "CSV"
require_relative './team'

class StatTracker
	attr_reader :seasons, :teams, :game_teams, :locations

	def initialize(locations)
		@season = create_seasons(location[:games])
		@games = CSV.read(locations[:games])
		@teams = create_teams(locations[:teams])
		@game_teams = CSV.read(locations[:game_teams])
	end

	def self.from_csv(locations)
		self.new(locations)
	end

	def create_teams(team_path)
		teams_storage = []
		CSV.foreach(team_path, :headers => true, header_converters: :symbol) do |row|
			teams_storage.push(Team.new(row))
		end
		teams_storage
	end

end
