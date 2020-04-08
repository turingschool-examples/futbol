class League

  def initialize

  end

  def count_of_teams
    Team.all_teams.count
  end

  def best_offense
    team_goal_totals = {}
    GameStats.all_game_stats.each do |game|
      if team_goal_totals[game.team_id] == nil
        team_goal_totals[game.team_id] = 0
      else
      team_goal_totals[game.team_id] += game.goals
      end
    end
    team_goal_totals.max_by do |keys, values|
    # team_goal_totals.select do |key, values|
    end
    # team_goal_totals.values.sort.last value
  end

end
