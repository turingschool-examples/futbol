module LeagueStatable
  
  def count_of_teams
    @teams.count
  end

  def team_list
    @teams.each_with_object(Hash.new) { |team, team_list| team_list[team.team_id] = team.team_name}
  end
  
  def total_goals_made_per_team
     @game_teams.each_with_object(Hash.new(0.0)) { |game, hash| hash[game.team_id] += game.goals.to_i}
   
  end

  def games_played_per_team
      @game_teams.each_with_object(Hash.new(0.0)) { |game, goals_made| goals_made[game.team_id] += 1}
  end
  
  def average_goals_per_team_id
    total_goals_made_per_team.each_with_object(Hash.new(0.0)) do |(key, value), hash|
      hash[key] = (value / games_played_per_team[key]).round(4)
    end
  end

  def best_offense
    max_average = average_goals_per_team_id.values.max
    best_team_id = average_goals_per_team_id.key(max_average)
    team_list[best_team_id]
  end
  
  def worst_offense
    max_average = average_goals_per_team_id.values.min
    worst_team_id = average_goals_per_team_id.key(max_average)
    team_list[worst_team_id]
  end

  def total_home_goals 
    total_goals = @game_teams.each_with_object({}) do |game, hash|
      hash[game.team_id] = hash[game.team_id] || [0, 0]
      hash[game.team_id] = [game.goals + hash[game.team_id][0], hash[game.team_id][1] + 1] if game.hoa == "home"
    end
  end

  def highest_scoring_home_team
    avg_goals = total_home_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    highest_avg_goals = avg_goals.values.max
    
    highest_team_id = avg_goals.key(highest_avg_goals)

    team_list[highest_team_id]
  end

  def lowest_scoring_home_team
    avg_goals = total_home_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    lowest_avg_goals = avg_goals.values.min

    lowest_team_id = avg_goals.key(lowest_avg_goals)

    team_list[lowest_team_id]
  end

  def total_away_goals 
    total_goals = @game_teams.each_with_object({}) do |game, hash|
      hash[game.team_id] = hash[game.team_id] || [0, 0]
      hash[game.team_id] = [game.goals + hash[game.team_id][0], hash[game.team_id][1] + 1] if game.hoa == "away"
    end
  end

  def highest_scoring_visitor
    avg_goals = total_away_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    highest_avg_goals = avg_goals.values.max
    
    highest_team_id = avg_goals.key(highest_avg_goals)

    team_list[highest_team_id]
  end

  def lowest_scoring_visitor
    avg_goals = total_away_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    lowest_avg_goals = avg_goals.values.min

    lowest_team_id = avg_goals.key(lowest_avg_goals)

    team_list[lowest_team_id]
  end
end