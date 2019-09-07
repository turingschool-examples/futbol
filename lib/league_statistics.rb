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

  def worst_offense
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
    lowest_team_id = goal_avg_by_team.key(goal_avg_by_team.values.min_by { |value| value})
    @teams.select do |team_id, team|
      lowest_team_id == team_id
    end[lowest_team_id].team_name
  end

  def best_defense
    home_teams = {}
    @games.each_value do |game|
      if !home_teams.has_key?(game.home_team_id)
        home_teams[game.home_team_id] = [game.away_goals]
      else
        home_teams[game.home_team_id].push(game.away_goals)
      end
    end

    away_teams = {}
    @games.each_value do |game|
      if !away_teams.has_key?(game.away_team_id)
        away_teams[game.away_team_id] = [game.home_goals]
      else
        away_teams[game.away_team_id].push(game.home_goals)
      end
    end

    teams = home_teams.merge(away_teams) { |team_id, home_team_val, away_team_val| home_team_val + away_team_val}

    goal_avg_by_team = {}
    teams.each do |team_id, goals_arr|
      total_goals = goals_arr.sum
      goal_avg_by_team[team_id] = (total_goals.to_f / goals_arr.length).round(2)
    end

    best_defense = goal_avg_by_team.key(goal_avg_by_team.values.min_by { |value| value})
    @teams.select do |team_id, team|
      best_defense == team_id
    end[best_defense].team_name
  end

  def worst_defense
    home_teams = {}
    @games.each_value do |game|
      if !home_teams.has_key?(game.home_team_id)
        home_teams[game.home_team_id] = [game.away_goals]
      else
        home_teams[game.home_team_id].push(game.away_goals)
      end
    end

    away_teams = {}
    @games.each_value do |game|
      if !away_teams.has_key?(game.away_team_id)
        away_teams[game.away_team_id] = [game.home_goals]
      else
        away_teams[game.away_team_id].push(game.home_goals)
      end
    end

    teams = home_teams.merge(away_teams) { |team_id, home_team_val, away_team_val| home_team_val + away_team_val}

    goal_avg_by_team = {}
    teams.each do |team_id, goals_arr|
      total_goals = goals_arr.sum
      goal_avg_by_team[team_id] = (total_goals.to_f / goals_arr.length).round(2)
    end

    worst_defense = goal_avg_by_team.key(goal_avg_by_team.values.max_by { |value| value})
    @teams.select do |team_id, team|
      worst_defense == team_id
    end[worst_defense].team_name
  end
end
