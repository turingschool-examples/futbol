require 'csv'

class StatTracker
	attr_reader :games,
							:teams,
							:game_teams

	def initialize(games, teams, game_teams)
		@games = games
		@teams = teams
		@game_teams = game_teams
	end

	def self.from_csv(multiple_data_paths) # in hash format
		games_data = CSV.open multiple_data_paths[:games], headers: true, header_converters: :symbol
		teams_data = CSV.open multiple_data_paths[:teams], headers: true, header_converters: :symbol
		game_teams_data = CSV.open multiple_data_paths[:game_teams], headers: true, header_converters: :symbol
		StatTracker.new(games_data, teams_data, game_teams_data)
	end

	def find_all_game_id
		@games.map do |row|
			row[:game_id]
		end
	end
end
