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

  def team_wins(team_id)
    @game_teams.find_all {|game| game.team_id == team_id && game.result == "WIN"}
  end

  def winning_game_ids(team_id)
    team_wins(team_id).map {|game| game.game_id}
  end

  def find_home_or_away(team_id)
    @games.find_all {|game| game.away_team_id == team_id || game.home_team_id == team_id}
  end

  def team_games_grouped_by_season(team_id)
    find_home_or_away(team_id).group_by {|game| game.season}
  end

  def best_season(team_id)
    team_games_grouped_by_season = find_home_or_away(team_id).group_by {|game| game.season}
    team_games_grouped_by_season.each do |season, games_array|
      wins = games_array.find_all {|game| winning_game_ids(team_id).include?(game.game_id)}.count
      team_games_grouped_by_season[season] = wins.to_f / games_array.count
    end
    team_games_grouped_by_season.max_by {|_, win_percentage| win_percentage}.first
  end

  def worst_season(team_id)
    team_games_grouped_by_season = find_home_or_away(team_id).group_by {|game| game.season}
    team_games_grouped_by_season.each do |season, games_array|
      wins = games_array.find_all {|game| winning_game_ids(team_id).include?(game.game_id)}.count
      team_games_grouped_by_season[season] = wins.to_f / games_array.count
    end
    team_games_grouped_by_season.min_by {|_, win_percentage| win_percentage}.first
  end

  def average_win_percentage(team_id)
    team_losses = @game_teams.find_all {|game| game.team_id == team_id && game.result == "LOSS"}.count
    team_ties = @game_teams.find_all {|game| game.team_id == team_id && game.result == "TIE"}.count
    total_games = team_wins(team_id).count + team_losses + team_ties
    (team_wins(team_id).count.to_f / total_games).round(2)
  end

  def find_all_games_by(team_id)
    @game_teams.find_all {|game| game.team_id == team_id}
  end

  def most_goals_scored(team_id)
    goals_scored = find_all_games_by(team_id).max_by do |game|
      game.goals
    end
    goals_scored.goals
  end

  def fewest_goals_scored(team_id)
    goals_scored = find_all_games_by(team_id).min_by do |game|
      game.goals
    end
    goals_scored.goals
  end

  def find_all_games_by_given_team_id(team_id)
    @games.find_all {|game| game.home_team_id == team_id || game.away_team_id == team_id}
  end

  def favorite_opponent(team_id)
    find_game_ids = find_all_games_by_given_team_id(team_id).map {|game| game.game_id}
    find_given_ids_opponents = @game_teams.find_all {|game| find_game_ids.include?(game.game_id) && game.team_id != team_id}
    sorted_by_team_id = find_given_ids_opponents.group_by {|game| game.team_id}
    result = sorted_by_team_id.transform_values do |game|
      count_of_wins = game.find_all do |game|
        (game.result == "WIN")
      end.count
      (count_of_wins.to_f / game.count).round(2)
    end
    the_team = result.min_by {|_, ratio| ratio}.first
    @teams.find {|team| team.team_id == the_team}.team_name
  end
  
  def rival(team_id)
    find_game_ids = find_all_games_by_given_team_id(team_id).map {|game| game.game_id}
    find_given_ids_opponents = @game_teams.find_all {|game| find_game_ids.include?(game.game_id) && game.team_id != team_id}
    sorted_by_team_id = find_given_ids_opponents.group_by {|game| game.team_id}
    result = sorted_by_team_id.transform_values do |game|
      count_of_wins = game.find_all do |game|
        (game.result == "WIN")
      end.count
      (count_of_wins.to_f / game.count).round(2)
    end
    the_team = result.max_by {|_, ratio| ratio}.first
    @teams.find {|team| team.team_id == the_team}.team_name
  end
end
