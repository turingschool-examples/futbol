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
		hash = Hash.new {|k, v| k[v] = []}
		array_of_game_ids.each do |game_id|
			games_by_game_id[game_id].each do |game|
				hash[game.info[:team_id]] << game.info[:tackles]
			end
		end
		hash
	end

	def game_ids_for_season(season_id)
		games_in_season = games_played_by_season(@games)[season_id]
		games_in_season.map do |game|
			game.info[:game_id]
		end
  end

end