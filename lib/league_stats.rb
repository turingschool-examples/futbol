module LeagueStats

  def worst_offense
    @teams.values.min_by{ |team| team.total_overall_goals.to_f / team.games_participated_in.length }.team_name
  end

  def best_offense
    @teams.values.max_by{ |team| team.total_overall_goals.to_f / team.games_participated_in.length }.team_name
  end

  def highest_scoring_home_team
    @teams.values.max_by {|team| team.total_home_goals.to_f / team.games_participated_in.length}.team_name
  end

  def lowest_scoring_home_team
    @teams.values.min_by {|team| team.total_home_goals.to_f / team.games_participated_in.length}.team_name
  end

  def highest_scoring_visitor
    high_scoring = teams_and_goals.max_by{|teams, stats| stats[:total_away_goals].to_f / stats[:total_away_games]}
    high_scoring[1][:team_name]
  end

end