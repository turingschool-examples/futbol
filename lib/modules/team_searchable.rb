module TeamSearchable
	def count_of_teams
		teams.length
	end

  def highest_scoring_visitor
		teams.max_by(&:average_goals_away).team_name
  end

  def highest_scoring_home_team
		teams.max_by(&:average_goals_home).team_name
  end

  def lowest_scoring_visitor
    teams.min_by(&:average_goals_away).team_name
  end

  def lowest_scoring_home_team
		teams.min_by(&:average_goals_home).team_name
  end
  
  def best_offense
		teams.max_by(&:average_goals_total).team_name
  end

	def worst_offense
		teams.min_by(&:average_goals_total).team_name
	end

	def winningest_team
		teams.max_by(&:win_percent_total).team_name
	end

	def worst_fans
		worst_fan_teams = teams.find_all { |team| team.average_goals_away > team.average_goals_home}
		worst_fan_teams.map(&:team_name)
	end

	def best_fans
		teams.max_by { |team| (team.home_win_percentage - team.away_win_percentage)}.team_name
	end

	def best_defense
		teams.min_by(&:total_scores_against).team_name
	end

	def worst_defense
		teams.max_by(&:total_scores_against).team_name
	end

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
			binding.pry
			games_to_return << games_between_teams(id, opp_team)
		end
		games_to_return
	end	
	
end

