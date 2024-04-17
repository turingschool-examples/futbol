

module LeagueStats
  def count_of_teams
    @teams.count
  end

  def best_offense
    average_game_points(team_id)
  end

  def average_game_points(team_id)
    total_points(team_id) / total_games(team_id)
  end

  def total_points(team_id)
    total = 0
    @games.each do |game|
      if game.home_team_id == team_id 
        total += game.home_goals.to_i
      elsif game.away_team_id == team_id
        total += game.away_goals.to_i
      end
    end
    total
  end

  def total_games(team_id)
    total = 0
    @games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        total += 1
      end
    end
    total
  end
end