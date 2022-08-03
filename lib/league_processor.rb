module LeagueProcessor

  def offense(value, game_teams)
      goals_by_team_id = Hash.new(0)
      game_count_by_team_id = Hash.new(0)
      game_teams.each do |game_team|
        goals_by_team_id[game_team.team_id.to_i] += game_team.goals.to_i
        game_count_by_team_id[game_team.team_id.to_i] += 1
      end
    if value == "best"
      average_teamid_score = goals_by_team_id.map{|team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
      best_offense_team_id = average_teamid_score.max_by { |team_id, average_goals| average_goals  }[0]
      return best_offense_team_id
    else
      average_teamid_score = goals_by_team_id.map{|team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
      worst_offense_team_id = average_teamid_score.min_by { |team_id, average_goals| average_goals }[0]
      return worst_offense_team_id
    end
  end

  def visitor_scoring_outcome(value, games)
      away_goals_by_team_id = Hash.new(0)
      game_count_by_team_id = Hash.new(0)
      games.each do |game|
        away_goals_by_team_id[game.away_team_id.to_i] += game.away_goals.to_i
        game_count_by_team_id[game.away_team_id.to_i] += 1
      end
    if value == "highest_scoring"
      average_teamid_score = away_goals_by_team_id.map { |team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
      best_away_team_id = average_teamid_score.max_by { |away_team_id, average_goals| average_goals }[0]
      return best_away_team_id
    else average_teamid_score = away_goals_by_team_id.map { |team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
      worst_away_team_id = average_teamid_score.min_by { |away_team_id, average_goals| average_goals }[0]
     return worst_away_team_id
    end
  end

  def home_scoring_outcome(value, games)
    home_goals_by_team_id = Hash.new(0)
    game_count_by_team_id = Hash.new(0)
    games.each do |game|
      home_goals_by_team_id[game.home_team_id.to_i] += game.home_goals.to_i
      game_count_by_team_id[game.home_team_id.to_i] += 1
    end
    if value == "highest_scoring"
      average_teamid_score = home_goals_by_team_id.map { |team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
      best_home_team_id = average_teamid_score.max_by { |home_team_id, average_goals| average_goals }[0]
      return best_home_team_id
    else average_teamid_score = home_goals_by_team_id.map { |team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
      worst_home_team_id = average_teamid_score.min_by { |home_team_id, average_goals| average_goals }[0]
      return worst_home_team_id
    end
  end

end
