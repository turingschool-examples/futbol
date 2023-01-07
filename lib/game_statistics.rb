require './lib/modules'

class GameStats
	include Sort

	attr_reader :games,
							:game_teams

	def initialize(games, game_teams)
		@games = games
		@game_teams = game_teams
	end

	def games_by_season(season)
		sort_objects_by(@games, :season)[season]
	end

	def average_goals_per_game
    average_score = total_scores.sum.to_f / total_scores.count
    average_score.round(2)
  end

	def total_scores
		@games.map do |game|
			game.info[:away_goals].to_i + game.info[:home_goals].to_i
		end
	end

	def percentage_home_wins
		h_wins = @game_teams.count do |game_team|
			game_team if game_team.info[:hoa] == "home" && game_team.info[:result] == "WIN"
		end
		(h_wins/@game_teams.count.to_f).round(2)*2
	end

	def percentage_visitor_wins
		v_wins = @game_teams.count do |game_team|
			game_team if game_team.info[:hoa] == "away" && game_team.info[:result] == "WIN"
		end
		(v_wins/@game_teams.count.to_f).round(2)*2
	end

	def percentage_ties
		ties = @game_teams.count do |game_team|
			game_team if game_team.info[:result] == "TIE"
		end
		(ties/@game_teams.count.to_f).round(2)
	end
end