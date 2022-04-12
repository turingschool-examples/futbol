require 'csv'
require './lib/team'

class StatTracker
	attr_reader :games, :teams, :game_teams

	def initialize(games, teams, game_teams)
		@games = games
		@teams = create_teams(teams)
		@game_teams = game_teams
	end

	def self.from_csv(locations)
	 games = CSV.open(locations[:games], headers: true, header_converters: :symbol)
	 teams = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
	 game_teams = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)
	 stat_tracker1 = self.new(games, teams, game_teams)
	end

	def create_teams(teams)
		team_arr = Array.new
		teams.each do |row|
			team_id = row[:team_id]
			franchise_id = row[:franchise_id]
			team_name = row[:team_name]
			abbreviation = row[:abbreviation]
			stadium = row[:stadium] # do symbols always return all lowercase or the same case as we assign it???
			link = row[:link]
			team_arr << Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
		end
		return team_arr
	end
end
