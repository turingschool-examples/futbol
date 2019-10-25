module LeagueModule

  def worst_defense
    teams_hash = game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = { :game_id => game_team.game_id, :opposing_goals => 0}
      acc
    end
    games.map do |game|
      teams_hash[game.home_team_id][:opposing_goals] += game.away_goals
      teams_hash[game.away_team_id][:opposing_goals] += game.home_goals
    end
    result = teams_hash.max_by do |key, value|
      teams_hash[key][:opposing_goals]
    end
    teams.map do |team|
      team.result[0] team.name 
    end
  end

  def highest_scoring_visitor
    skip
  end

  def highest_scoring_home_team
    skip
  end

  def lowest_scoring_visitor
    skip
  end

end
