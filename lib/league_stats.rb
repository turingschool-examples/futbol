module LeagueStats

  def worst_offense
    @teams.values.min_by{ |team| team.total_overall_goals / team.games_participated_in.length }.team_name
  end

end