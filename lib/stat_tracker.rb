require "CSV"
require_relative './team'
require_relative './season'
require_relative './game'

class StatTracker
	attr_reader :seasons, :teams, :game_teams, :locations

	def initialize(locations)
		@seasons = create_seasons(locations[:games], locations[:game_teams])
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

	def create_seasons(season_path, gt_path)
		season_ids = []
		season_storage = []
		CSV.foreach(season_path, :headers => true, header_converters: :symbol) do |row|
			season_ids.push(row[1])
		end
		season_ids.uniq.each {|id| season_storage.push(Season.new({id: id, path: season_path}, gt_path))}
		season_storage
	end

	def count_of_teams
		@teams.length
	end

	def highest_scoring_visitor
		@teams.max_by(&:average_goals_away).team_name
	end

  #alex
	def highest_scoring_home_team
		@teams.max_by(&:average_goals_home).team_name
	end

	def lowest_scoring_visitor
		@teams.min_by(&:average_goals_away).team_name
	end

	def lowest_scoring_home_team
		@teams.min_by(&:average_goals_home).team_name
	end

	def count_of_games_by_season
		games_by_season = {}
		@seasons.each {|season| games_by_season[season.id.to_s] = season.total_games}
		return games_by_season
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
		home_wins = Game.all.find_all { |game| game.home_goals > game.away_goals }
		return ((home_wins.length.to_f/Game.all.length)).round(2)
	end

	def percentage_visitor_wins
		away_wins = Game.all.find_all { |game| game.away_goals > game.home_goals }
		return ((away_wins.length.to_f/Game.all.length)).round(2)
	end

	def percentage_ties
		ties = Game.all.find_all { |game| game.winner == nil }
		return ((ties.length.to_f/Game.all.length)).round(2)
	end

	def average_goals_per_game
		total_goals = Game.all.map {|game| game.total_score}
		return ((total_goals.sum.to_f / Game.all.length).round(2))
	end

	def average_goals_by_season
		@seasons.reduce({}) do |acc, season|
			acc[season.id.to_s] = (season.games_unsorted.sum {|game| game.total_score}/season.games_unsorted.length.to_f).round(2)
			acc
		end
	end

	def best_offense
		@teams.max_by { |team| team.average_goals_total }.team_name
	end

	def worst_offense
		@teams.min_by { |team| team.average_goals_total }.team_name
	end

	def winningest_team
		@teams.max_by { |team| team.win_percent_total }.team_name
	end

	def worst_fans
		worst_fan_teams = @teams.find_all { |team| team.average_goals_away > team.average_goals_home}
		worst_fan_teams.map(&:team_name)
	end

	def best_fans
		@teams.max_by { |team| (team.home_win_percentage - team.away_win_percentage)}.team_name
	end

	def best_defense
		@teams.min_by { |team| team.total_scores_against }.team_name
	end

	def worst_defense
		@teams.max_by { |team| team.total_scores_against }.team_name
	end
end
