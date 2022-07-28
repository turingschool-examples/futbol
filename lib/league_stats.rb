module LeagueStats

  def worst_offense
    @teams.values.min_by{ |team| team.total_overall_goals }.team_name
  end

end