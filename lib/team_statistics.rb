class TeamStatistics

  def team_info(team_id)
     found_team = @teams.find do |team|
       team.team_id == team_id
     end
     {
       :team_id => found_team.team_id,
       :franchise_id => found_team.franchise_id,
       :team_name => found_team.team_name,
       :abbreviation => found_team.abbreviation,
       :link => found_team.link
     }
  end

  def best_season(team_id)
  end

  def worst_season(team_id)
  end

  def average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
  end
end
