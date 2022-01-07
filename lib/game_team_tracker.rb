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

  def highest_scoring_visitor
    highest_visitor = {}
    away_array = @game_teams.find_all do |game|
      game if game.hoa == "away"
    end
    away_team = away_array.group_by {|game| game.team_id}
    key_hash = {}
    #goal_average_calculator(team_hash)
    away_team.map do |key, away_team|
      goals = away_team.sum {|game| game.goals}
      total_games = away_team.count
      average = goals.to_f / total_games
      key_hash[key] = average
      key_hash = key_hash.to_h
      max = key_hash.values.max
      highest_visitor = key_hash.select {|k,v| v == max}
    end
    find_name_by_ID(highest_visitor.keys[0])[0].teamname
    #binding.pry
  end

  # def highest_scoring_home_team
  #
  # end
end
