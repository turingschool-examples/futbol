require "CSV"
require_relative './team'
require_relative './season'

class StatTracker
	attr_reader :seasons, :teams, :game_teams, :locations

	def initialize(locations)
		@seasons = create_seasons(locations[:games])
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

	def create_seasons(season_path)
		season_ids = []
		season_storage = []
		CSV.foreach(season_path, :headers => true, header_converters: :symbol) do |row|
			season_ids.push(row[1])
		end
		season_ids.uniq.each {|id| season_storage.push(Season.new({id: id, path: season_path}))}
		season_storage
	end

end
