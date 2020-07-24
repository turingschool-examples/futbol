class TeamStats < Stats


  def team_info(team_id)
    result = @teams.find do |team|
      team.team_id == team_id
    end
    {"team_id" => result.team_id,
    "franchise_id" => result.franchise_id,
    "team_name" => result.team_name,
    "abbreviation" => result.abbreviation,
    "link" => result.link}
  end

  def best_season(team_id)
    team_wins = @game_teams.find_all {|game| game.team_id == team_id && game.result == "WIN"}
    winning_game_ids = team_wins.map {|game| game.game_id}
    team_games = @games.find_all {|game| game.away_team_id == team_id || game.home_team_id == team_id}
    team_games_grouped_by_season = team_games.group_by {|game| game.season}
    team_games_grouped_by_season.each do |season, games_array|
      wins = games_array.find_all {|game| winning_game_ids.include?(game.game_id)}.count
      team_games_grouped_by_season[season] = wins.to_f / games_array.count
    end
    team_games_grouped_by_season.max_by {|_, win_percentage| win_percentage}.first
  end

  def worst_season(team_id)
    team_wins = @game_teams.find_all {|game| game.team_id == team_id && game.result == "WIN"}
    winning_game_ids = team_wins.map {|game| game.game_id}
    team_games = @games.find_all {|game| game.away_team_id == team_id || game.home_team_id == team_id}
    team_games_grouped_by_season = team_games.group_by {|game| game.season}
    team_games_grouped_by_season.each do |season, games_array|
      wins = games_array.find_all {|game| winning_game_ids.include?(game.game_id)}.count
      team_games_grouped_by_season[season] = wins.to_f / games_array.count
    end
    team_games_grouped_by_season.min_by {|_, win_percentage| win_percentage}.first
  end

  def average_win_percentage(team_id)
    team_wins = @game_teams.find_all {|game| game.team_id == team_id && game.result == "WIN"}.count
    team_losses = @game_teams.find_all {|game| game.team_id == team_id && game.result == "LOSS"}.count
    team_ties = @game_teams.find_all {|game| game.team_id == team_id && game.result == "TIE"}.count
    total_games = team_wins + team_losses + team_ties
    (team_wins.to_f / total_games).round(2)
  end

  def most_goals_scored(team_id)
    team = @game_teams.find_all {|game| game.team_id == team_id}
    x = team.max_by do |game|
      game.goals
    end
    x.goals
  end

  def fewest_goals_scored(team_id)
    team = @game_teams.find_all {|game| game.team_id == team_id}
    x = team.min_by do |game|
      game.goals
    end
    x.goals
  end
end
