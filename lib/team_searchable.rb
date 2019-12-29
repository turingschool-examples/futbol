module TeamSearchable
  def highest_scoring_visitor
    # merge_sort(@teams, "average_goals_away")[-1].team_name
		@teams.max_by(&:average_goals_away).team_name
	end

  def highest_scoring_home_team
    # merge_sort(@teams, "average_goals_home")[-1].team_name
		@teams.max_by(&:average_goals_home).team_name
	end

  def lowest_scoring_visitor
    # merge_sort(@teams, "average_goals_away")[0].team_name
    @teams.min_by(&:average_goals_away).team_name
	end

  def lowest_scoring_home_team
    # merge_sort(@teams, "average_goals_home")[0].team_name
		@teams.min_by(&:average_goals_home).team_name
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