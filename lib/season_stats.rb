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

  def most_accurate_team(season_id)
		game_ids = game_ids_for_season(season_id)
		team_accuracy = accuracy_by_team(game_ids)
		team_id = team_accuracy.key(team_accuracy.values.max)
		team_name_by_id(team_id)
	end

	def least_accurate_team(season_id)
		game_ids = game_ids_for_season(season_id)
		team_accuracy = accuracy_by_team(game_ids)
		team_id = team_accuracy.key(team_accuracy.values.min)
		team_name_by_id(team_id)
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

  ##HELPERS
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

	def coach_game_results_by_game(array_of_game_id)
		coach_results = Hash.new {|k, v| k[v] = []}
		array_of_game_id.each do |game_id|
			games_by_game_id[game_id].each do |game|
				coach_results[game.info[:head_coach]] << game.info[:result]
			end
		end
		coach_results
	end

	def accuracy_by_team(array_of_game_id)
		team_accuracy = Hash.new {|k, v| k[v] = [0.0,0.0]}
		array_of_game_id.each do |game_id|
			games_by_game_id[game_id].each do |game|
				team_accuracy[game.info[:team_id]][0] += game.info[:goals].to_f
				team_accuracy[game.info[:team_id]][1] += game.info[:shots].to_f
			end
		end
		team_accuracy.each do |team_id, array|
			team_accuracy[team_id] = team_accuracy[team_id].reduce(&:/)
		end
	end

end