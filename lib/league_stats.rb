

module LeagueStats
  def count_of_teams
    @teams.count
  end
  
  def best_offense
    team_averages_list.max_by {|key, value| value}.first
  end

  def worst_offense
    team_averages_list.min_by {|key, value| value}.first
  end
  
  def team_averages_list
    team_averages = {}
    @teams.each do |team|
      if total_games(team.team_id) != 0
        team_averages[team.team_name] = average_game_points(team.team_id)
      end
    end
    team_averages
  end

  def average_game_points(team_id)
    (total_points(team_id).to_f / total_games(team_id)).round(2)
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