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

	def highest_scoring_visitor
		team = @teams.max_by do |team|
			team.average_goals_away
		end
		team.team_name
	end

	def highest_scoring_home_team
		team = @teams.max_by do |team|
			team.average_goals_home
		end
			team.team_name
	end

	def lowest_scoring_visitor
		team = @teams.min_by do |team|
			team.average_goals_away
		end
		team.team_name
	end

	def lowest_scoring_home_team
		team = @teams.min_by do |team|
			team.average_goals_home
		end
			team.team_name
	end

	def count_of_games_by_season
		games_by_season = {}
			@seasons.each {|season| games_by_season[season.id] = season.total_games}
			return games_by_season
	end

	def winningest_team
		@teams.max_by do |team|
			team.total_winning_percentage
		end.team_name
	end

	def worst_fans
		teams = @teams.find_all do |team|
			team.away_games_won.length > team.home_games_won.length
		end
		teams.map do |team|
			team.team_name
		end
	end

	def best_fans
		team = @teams.max_by do |team|
			team.home_win_percentage - team.away_win_percentage
		end
		team.team_name
	end

	def highest_total_score
		Game.all.max_by {|game| game.total_score}.total_score
	end

	def lowest_total_score
		Game.all.min_by {|game| game.total_score}.total_score
	end

	def biggest_blowout
		Game.all.max_by {|game| game.score_difference}.score_difference
	end

	def percentage_home_wins
		home_wins = Game.all.find_all do |game|
			game.home_goals > game.away_goals
		end
		return ((home_wins.length.to_f/Game.all.length).round(2))
	end

	def percentage_visitor_wins
		away_wins = Game.all.find_all do |game|
			game.away_goals > game.home_goals
		end
		return ((away_wins.length.to_f/Game.all.length).round(2))
	end

	def percentage_ties
		ties = Game.all.find_all do |game|
			game.winner == nil
		end
		return ((ties.length.to_f/Game.all.length)).round(2)
	end

	def average_goals_per_game
		total_goals = Games.all.map {|game| game.total_score}
		return ((total_goals.sum.to_f / Game.all.length)).round(2)
	end

	def count_of_teams
		@teams.length
	end
end
