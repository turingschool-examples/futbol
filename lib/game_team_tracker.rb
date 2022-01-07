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

      #key_hash = key_hash.each_pair.to_h
      # key_hash = key_hash.each_pair.to_h
      best_team = key_hash.select {|k,v| v == max}

    end
    #binding.pry
    best_team
  end

  def worst_offense
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
      #binding.pry
    end
    worst_team
  end

#  team[key].team_id
end
