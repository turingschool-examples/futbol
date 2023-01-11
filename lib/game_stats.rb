require './lib/modules'

class GameStats
	include Sort

	attr_reader :games,
							:game_teams,
							:teams

	def initialize(games, game_teams, teams)
		@games = games
		@game_teams = game_teams
		@teams = teams
	end

	def highest_total_score
		total_scores.max
	end

	def lowest_total_score
		total_scores.min
	end

	def percentage_home_wins
		home_wins = @game_teams.count do |game_team|
			game_team if game_team.info[:hoa] == "home" && game_team.info[:result] == "WIN"
		end
		(home_wins/@game_teams.count.to_f).round(2)*2
	end

	def percentage_visitor_wins
		visitor_wins = @game_teams.count do |game_team|
			game_team if game_team.info[:hoa] == "away" && game_team.info[:result] == "WIN"
		end
		(visitor_wins/@game_teams.count.to_f).round(2)*2
	end

	def percentage_ties
		ties = @game_teams.count do |game_team|
			game_team if game_team.info[:result] == "TIE"
		end
		(ties/@game_teams.count.to_f).round(2)
	end

	def count_of_games_by_season
		game_counts = {}
		games_played_by_season.map do |season_id, games|
			game_counts[season_id.to_s] = games.size
		end
		game_counts
	end

	def average_goals_per_game
    average_score = total_scores.sum.to_f / total_scores.count
    average_score.round(2)
  end

	def average_goals_by_season
		season_total_scores = Hash.new {|k, v| k[v] = []}
		games_played_by_season.each do |season, games|
			sum_of_goals = games.sum { |game| game.info[:home_goals] + game.info[:away_goals] }
			season_total_scores[season.to_s] = (sum_of_goals/games.count.to_f).round(2)
		end
		season_total_scores
	end
	
	## Helpers
	def total_scores
		@games.map do |game|
			game.info[:away_goals].to_i + game.info[:home_goals].to_i
		end
	end
end