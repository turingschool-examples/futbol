module LeagueStatistics
  def count_of_teams
    @teams.count
  end

  def total_goals_all_seasons(team_id)
    total = 0
    @game_teams.each do |team|
      total += team[:goals].to_i if team_id == team[:team_id].to_i
    end
    total
  end

  def total_games_all_seasons(team_id)
    total = 0
    @game_teams.each do |team|
      total += 1 if team_id == team[:team_id].to_i
    end
    total
  end

  def average_goals_all_seasons(team_id)
    avg = total_goals_all_seasons(team_id) / total_games_all_seasons(team_id).to_f
    avg.round(2)
  end

  def team_by_id(team_id)
    get_team = nil
    @teams.each do |team|
      get_team = team if team_id == team[:team_id].to_i
    end
    get_team[:teamname]
  end

  def best_offense
    best = 0
    team_name = nil
    @teams.each do |team|
      avg = average_goals_all_seasons(team[:team_id].to_i)
      if avg > best
        best = avg
        team_name = team[:teamname]
      end
    end
    team_name
  end

  def worst_offense
    lowest = 100_000
    team_name = nil
    @teams.each do |team|
      avg = average_goals_all_seasons(team[:team_id].to_i)
      if avg < lowest
        lowest = avg
        team_name = team[:teamname]
      end
    end
    team_name
  end
end
