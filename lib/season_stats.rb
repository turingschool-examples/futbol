class SeasonStats < Stats

  # def unique_games
  #   @games.count
  # end
  def gather_season_games(season_id)
    games_within_season = @games.select {|game| game.season == season_id}
    game_ids = games_within_season.collect {|game| game.game_id}
    @game_teams.select {|game| game_ids.include?(game.game_id)}
  end

  def group_season_wins_by_coach(season_id)
    season_game_ids = gather_season_games(season_id)
    games_grouped_by_coach = season_game_ids.group_by {|game| game.head_coach}
    games_grouped_by_coach.each do |coach, games_array|
      games_grouped_by_coach[coach] = games_array.find_all {|game| game.result == "WIN"}.count
    end
  end

  def winningest_coach(season_id)
    season_wins_grouped_by_coach = group_season_wins_by_coach(season_id)
    season_wins_grouped_by_coach.max_by {|_, wins| wins}.first
  end

  def worst_coach(season_id)
    season_wins_grouped_by_coach = group_season_wins_by_coach(season_id)
    season_wins_grouped_by_coach.min_by {|_, wins| wins}.first
  end

  def most_accurate_team(season_id)
    games_within_season = gather_season_games(season_id)
    team_id = games_within_season.group_by {|team| team.team_id}
    goals = team_id.transform_values do |game_team|
      game_team.sum {|game| game.goals.to_f} / game_team.sum {|game| game.shots}
      require "pry"; binding.pry
    end
    @teams.find {|team| team.team_id == goals.max_by {|_, ratio| ratio}.first}.team_name
  end

  def least_accurate_team(season_id)
    games_within_season = gather_season_games(season_id)
    team_id = games_within_season.group_by {|team| team.team_id}
    goals = team_id.transform_values do |game_team|
      game_team.sum {|game| (game.goals).to_f} / game_team.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == goals.min_by {|_, ratio| ratio}.first}.team_name
  end

  def most_tackles(season_id)
    games_within_season = gather_season_games(season_id)
    team_id = games_within_season.group_by {|team| team.team_id}
    tackles = team_id.transform_values do |game_team|
      game_team.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == tackles.max_by {|_, ratio| ratio}.first}.team_name
  end

  def fewest_tackles(season_id)
    games_within_season = gather_season_games(season_id)
    team_id = games_within_season.group_by {|team| team.team_id}
    tackles = team_id.transform_values do |game_team|
      game_team.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == tackles.min_by {|_, ratio| ratio}.first}.team_name
  end
end
