module LeagueStatistics

  def count_of_teams
    @teams.length
  end

  def best_offense
    games_by_team = @game_teams.group_by do |game_team|
      game_team.team_id
    end
    goal_avg_by_team = {}
    games_by_team.each do |team_id, games_arr|
      total_goals = games_arr.sum do |game|
        game.goals
      end
      goal_avg_by_team[team_id] = (total_goals.to_f / games_arr.length).round(2)
    end
    highest_team_id = goal_avg_by_team.key(goal_avg_by_team.values.max_by { |value| value})
    @teams.select do |team_id, team|
      highest_team_id == team_id
    end[highest_team_id].team_name
  end
end
