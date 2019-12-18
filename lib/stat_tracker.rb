require "CSV"
require_relative './team'
require_relative './season'
require_relative './digger'

class StatTracker
	include Digger
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

	def all_games

	end

	def highest_scoring_visitor
		team = @teams.max_by do |team|
			team.average_goals_away
		end
		team.team_name
	end

	def highest_scoring_home_team
		@away_goals.map do |score|
			score.max
			return @home_team_id
		end
	end

	def lowest_scoring_visitor
		@away_goals.map do |score|
			score.min
			return @away_team_id
		end
	end
	def lowest_scoring_home_team
		@home_goals.map do |score|
			score.min
			return @home_team_id
		end
	end

	def count_of_games_by_season
		games_by_season = {}
			@seasons.each {|season| games_by_season[season.id] = season.total_games}
			return games_by_season
	end

	# def average_goals_by_season
	# 	goals_by_season = {}
	# 	@seasons.each {|season| goals_by_season[season.id] = season.total_games}
	# end


end
