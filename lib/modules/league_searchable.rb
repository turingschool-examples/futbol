module LeagueSearchable

	def team_ids
		teams.map(&:team_id)
	end

	def games_between_teams(id, opp_id)
		games_to_return = []
		Game.all.each do |game|
			if (game.home_team_id == id || game.away_team_id == id)
				if (game.home_team_id == opp_id || game.away_team_id == opp_id)
					games_to_return << game
				end
			end
		end
		simplify_games_between_teams(id, games_to_return)
	end

	def simplify_games_between_teams(id, games)
		updated_games = []
		games.map do |game|
			game_holder = []
			if game.home_team_id == id
				game_holder << game.id
				game_holder << game.away_team_id
				game_holder << game.home_goals
				game_holder << game.away_goals
				updated_games << game_holder
			elsif game.away_team_id == id
				game_holder << game.id
				game_holder << game.home_team_id
				game_holder << game.away_goals
				game_holder << game.home_goals
				updated_games << game_holder
			end
		end
		updated_games = updated_games.uniq
		updated_games.map {|game| game.delete_at(0)}
		updated_games
	end

	def games_for_team(id)
		loop_teams = team_ids
		loop_teams.delete(id)
		games_to_return = []
		loop_teams.map do |opp_team|
			games_to_return << games_between_teams(id, opp_team)
		end
		games_to_return.reject(&:empty?).flatten(1)
	end

	def favorite_opponenent_id(id)
		all_games = games_for_team(id)
		all_games_by_team = organize_by_team(all_games)
		wins_by_team = convert_to_wins(all_games_by_team)
		win_percent_per_opp = win_percent_by_opp(wins_by_team)
		win_percent_per_opp.key(win_percent_per_opp.values.max)
	end

	def rival_id(id)
		all_games = games_for_team(id)
		all_games_by_team = organize_by_team(all_games)
		wins_by_team = convert_to_wins(all_games_by_team)
		win_percent_per_opp = win_percent_by_opp(wins_by_team)
		win_percent_per_opp.key(win_percent_per_opp.values.min)
	end

	def rival(id)
		team_from_id(rival_id(id.to_i))
	end

	def favorite_opponent(id)
		team_from_id(favorite_opponenent_id(id.to_i))
	end

	def team_from_id(id)
		teams.find {|team| team.team_id == id}.team_name
	end

	def organize_by_team(games)
		games.reduce({}) do |total, game|
			if total[game[0]] == nil
				total[game[0]] = [game[1,2]]
				total
			else
				total[game[0]] << game[1,2]
				total
			end
		end
	end

	def win_percent_by_opp(games_hash)
		updated_games_hash = {}
		games_hash.each do |opp, w_l|
			updated_games_hash[opp] = win_percent(w_l)
		end
		updated_games_hash
	end

	def win?(scores)
		if scores[0] > scores[1]
			return true
		else
			return false
		end
	end

	def convert_to_wins(games_hash)
		updated_games_hash = {}
		games_hash.each do |opp, games|
			updated_games_hash[opp] = games.map do |scores|
				win?(scores)
			end
		end
		updated_games_hash
	end

	def win_percent(w_l)
		win_count = 0
		game_count = 0
		w_l.each do |game|
			if game
				win_count += 1
				game_count += 1
			else
				game_count += 1
			end
		end
		win_count.to_f / game_count.to_f
	end

	def biggest_team_blowout(id)
		all_games = games_for_team(id.to_i)
		win_loss_games = win_loss_difference(all_games)
		win_loss_games.max
	end

	def worst_loss(id)
		all_games = games_for_team(id.to_i)
		win_loss_games = win_loss_difference(all_games)
		win_loss_games.min.abs
	end

	def win_loss_difference(games)
		games.map do |game|
			game[1] - game[2]
		end
	end

	def head_to_head(id)
		all_games = games_for_team(id.to_i)
		all_games_by_team = organize_by_team(all_games)
		wins_by_team = convert_to_wins(all_games_by_team)
		win_percent_per_opp = win_percent_by_opp(wins_by_team)
		final_hash = {}
		win_percent_per_opp.each do |opp, win_percent|

			final_hash[team_from_id(opp)] = win_percent.round(2)
		end
		final_hash
	end

end
