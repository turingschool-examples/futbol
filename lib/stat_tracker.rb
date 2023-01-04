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
		games_data = CSV.read multiple_data_paths[:games], headers: true, header_converters: :symbol
		teams_data = CSV.read multiple_data_paths[:teams], headers: true, header_converters: :symbol
		game_teams_data = CSV.read multiple_data_paths[:game_teams], headers: true, header_converters: :symbol
		StatTracker.new(games_data, teams_data, game_teams_data)
	end

	def find_all_game_id
		@games.map do |row|
			row[:game_id]
		end
	end

	def total_scores
		@games.map do |row|
			row[:away_goals].to_i + row[:home_goals].to_i
		end
	end

	def highest_total_score
		total_scores.max
	end

	def lowest_total_score
		total_scores.min
	end

	def most_goals_scored(team_id)
		all_game_scores_by_team[team_id.to_s].max.to_i
	end
	
	def fewest_goals_scored(team_id)
		all_game_scores_by_team[team_id.to_s].min.to_i
	end

	def all_game_scores_by_team
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |row|
			hash[row[:home_team_id]] << row[:home_goals]
			hash[row[:away_team_id]] << row[:away_goals]
		end
		hash
	end

	def count_of_games_by_season
		@games.map do |row|
			row[:season]
		end.tally
	end
  
end
