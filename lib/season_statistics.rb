require './lib/modules'

class SeasonStats
	include Sort

	attr_reader :games,
							:game_teams,
							:teams

	def initialize(games, game_teams, teams)
		@games = games
		@game_teams = game_teams
		@teams = teams
	end

	def most_tackles(season_id)
		team_tackles = season_team_tackles(season_id)
		team_id = team_tackles.key(team_tackles.values.max)
		team_name_by_id(team_id)
	end

	def fewest_tackles(season_id)
		team_tackles = season_team_tackles(season_id)
		team_id = team_tackles.key(team_tackles.values.min)
		team_name_by_id(team_id)
	end

	def season_team_tackles(season_id)
		array_of_game_ids = game_ids_for_season(season_id)
		team_tackles_hash = tackles_by_team_id(array_of_game_ids)
		team_tackles_hash.each do |k,v|
			team_tackles_hash[k] = v.sum
		end
		team_tackles_hash
	end

	def tackles_by_team_id(array_of_game_ids)
		team_tackles = Hash.new {|k, v| k[v] = []}
		array_of_game_ids.each do |game_id|
			games_by_game_id[game_id].each do |game|
				team_tackles[game.info[:team_id]] << game.info[:tackles]
			end
		end
		team_tackles
	end

	def game_ids_for_season(season_id)
		games_in_season = games_played_by_season(@games)[season_id]
		games_in_season.map do |game|
			game.info[:game_id]
		end
  end

	def winningest_coach(season_id)
		game_ids = game_ids_for_season(season_id)
		coach_game_results = coach_game_results_by_game(game_ids)
		coach_game_results.each do |k, v|
			coach_game_results[k] = (v.count('WIN') / (games.count / 2).to_f )
		end.key(coach_game_results.values.max)
	end

	def worst_coach(season_id)
		game_ids = game_ids_for_season(season_id)
		coach_game_results = coach_game_results_by_game(game_ids)
		coach_game_results.each do |k, v|
			coach_game_results[k] = (v.count('WIN') / (games.count / 2).to_f )
		end.key(coach_game_results.values.min)
	end

	def coach_game_results_by_game(array_of_game_id)
		coach_results = Hash.new {|k, v| k[v] = []}
		array_of_game_id.each do |game_id|
			games_by_game_id[game_id].each do |game|
				coach_results[game.info[:head_coach]] << game.info[:result]
			end
		end
		coach_results
	end

end