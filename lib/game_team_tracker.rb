class GameTeamTracker < Statistics
  def count_of_teams
    unique = @game_teams.map {|game|game.team_id}
    unique.uniq.count
  end

  def best_offense # look at breaking into different methods
    best_team = {}
    max = 0
    sorted = @game_teams.group_by {|game| game.team_id}
    key_hash = {}
    #goal_average_calculator(team_hash)
    sorted.map do |key, sorted|
      goals = sorted.sum {|game| game.goals}
      total_games = sorted.count
      average = goals.to_f / total_games
      key_hash[key] = average
      key_hash = key_hash.to_h
      max = key_hash.values.max
      best_team = key_hash.select {|k,v| v == max}
    end
    find_name_by_ID(best_team.keys[0])[0].teamname
  end

  def worst_offense # look at breaking into different methods
    worst_team = {}
    min = 0
    sorted = @game_teams.group_by {|game| game.team_id}
    key_hash = {}
    #goal_average_calculator(team_hash)
    sorted.map do |key, sorted|
      goals = sorted.sum {|game| game.goals}
      total_games = sorted.count
      average = goals.to_f / total_games
      key_hash[key] = average
      key_hash = key_hash.to_h
      min = key_hash.values.min
      worst_team = key_hash.select {|k,v| v == min}
    end
    find_name_by_ID(worst_team.keys[0])[0].teamname
  end
end
