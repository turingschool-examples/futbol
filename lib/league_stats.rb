module LeagueStats

  def worst_offense
    @teams.values.min_by{ |team| team.total_overall_goals.to_f / team.games_participated_in.length }.team_name
  end

  def best_offense
    @teams.values.max_by{ |team| team.total_overall_goals.to_f / team.games_participated_in.length }.team_name
  end

  def highest_scoring_home_team
    @teams.values.max_by {|team| team.total_goals_per_side(:home_team).to_f / team.games_participated_in.length}.team_name
  end

  def lowest_scoring_home_team
    @teams.values.min_by {|team| team.total_goals_per_side(:home_team).to_f / team.games_participated_in.length}.team_name
  end

  def highest_scoring_visitor
    @teams.values.max_by {|team| team.total_goals_per_side(:away_team).to_f / team.games_participated_in.length}.team_name
  end

  def lowest_scoring_visitor
    @teams.values.min_by {|team| team.total_goals_per_side(:away_team).to_f / team.games_participated_in.length}.team_name
  end

  def count_of_teams
    @teams.values.uniq.count
  end

  def average_win_percentage(team_id)
    total_win_percent = 0
    @teams.values.each do |team|
      if team.team_id.to_s == team_id
        team.win_percentages_by_season.values.each do |value|
          total_win_percent += value
        end
      end
    end
    (total_win_percent / @seasons.length).round(2)
  end

end
