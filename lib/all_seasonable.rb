module AllSeasonable

  def games_average(team_id)
    goals_scored = 0.00
    games_by_team(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored / games_by_team(team_id).length
  end

  def games_by_team(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id.to_s
    end
  end

  def away_games(team_id)
    games_by_team(team_id).find_all do |game|
      game.hoa == 'away'
    end
  end

  def away_average(team_id)
    goals_scored = 0.00
    away_games(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored.fdiv(away_games(team_id).length)
  end
  
  def home_games(team_id)
    games_by_team(team_id).find_all do |game|
      game.hoa == 'home'
    end
  end

  def home_average(team_id)
    goals_scored = 0.00
    home_games(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored.fdiv(home_games(team_id).length)
  end

end
