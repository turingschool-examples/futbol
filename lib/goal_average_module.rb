module GoalAverage

  def highest_scoring_visitor
    @teams.teams.find do |team|
    if @games.away_team_id_for_highest_average_goals.to_i == team.team_id
    team.team_name
    end
    end
  end
end
