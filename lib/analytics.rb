module Analytics
  def find_average(collection, hash1, hash2, id1, id2)
    collection.each do |element|
      teams_total_scores[game_team.team_id] += game_team.goals.to_f
      teams_total_games[game_team.team_id] += 1.0
    end
  end

  def total_teams_average(game_team_collection)
    teams_total_scores = Hash.new{0}
    teams_total_games = Hash.new{0}
    teams_total_averages = Hash.new{0}
    
    game_team_collection.add_total_score_and_games(teams_total_scores, teams_total_games)
    
    teams_total_scores.each do |key, value|
      teams_total_averages[key] = (value / teams_total_games[key].to_f).round(5)
    end
    
    teams_total_averages
  end

  def total_away_teams_average(game_team_collection)
    teams_total_away_scores = Hash.new{0}
    teams_total_away_games = Hash.new{0}
    teams_total_away_averages = Hash.new{0}
    
    game_team_collection.add_total_away_score_and_away_games(teams_total_away_scores, teams_total_away_games)
    
    teams_total_away_scores.each do |key, value|
      teams_total_away_averages[key] = (value / teams_total_away_games[key].to_f).round(5)
    end

    teams_total_away_averages
  end

  def total_home_teams_average(game_team_collection)
    teams_total_home_scores = Hash.new{0}
    teams_total_home_games = Hash.new{0}
    teams_total_home_averages = Hash.new{0}
    
    game_team_collection.add_total_home_score_and_home_games(teams_total_home_scores, teams_total_home_games)
    
    teams_total_home_scores.each do |key, value|
      teams_total_home_averages[key] = (value / teams_total_home_games[key].to_f).round(5)
    end

    teams_total_home_averages
  end
end