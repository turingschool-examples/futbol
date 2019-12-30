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

end