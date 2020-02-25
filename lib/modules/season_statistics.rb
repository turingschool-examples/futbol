module SeasonStatistcs

  def gameid_of_games_that_season(season_id)
    games_that_season = @games.find_all {|game| game.season == season_id}
    games_that_season.map {|game| game.game_id}
  end


  def game_teams_that_season(team_id, season_id)
    @game_teams.find_all do |game_team|
      gameid_of_games_that_season(season_id).include?(game_team.game_id) && game_team.team_id == team_id
    end
  end

  def create_hash_with_team_games_by_team(season_id)
    all_teams_playing.reduce({}) do |teams_and_games, team_id|
      teams_and_games[team_id] = game_teams_that_season(team_id, season_id)
      teams_and_games
    end
  end

  def teams_with_goals_total(season_id)
    create_hash_with_team_games_by_team(season_id).transform_values do |game_team|
      game_team.sum{|game| game.goals}
    end
  end

  def teams_with_shots_total(season_id)
    create_hash_with_team_games_by_team(season_id).transform_values do |game_team|
      game_team.sum{|game| game.shots}
    end
  end

  def getting_goals_to_shots_ratio(season_id)
    goals_to_shots_ratio = {}
    teams_with_goals_total(season_id).map do |team_id, goals|
      goals_to_shots_ratio[team_id] = (goals.to_f / teams_with_shots_total(season_id)[team_id]).round(2)
    end
    goals_to_shots_ratio
  end

  def most_accurate_team(season_id)
    team = getting_goals_to_shots_ratio(season_id).max_by do |team_id, ratio|
      ratio
    end
    find_team_names(team[0])
  end

  def least_accurate_team(season_id)
    team = getting_goals_to_shots_ratio(season_id).min_by {|team_id, ratio| ratio}
    find_team_names(team[0])
  end

  def all_coaches
    @game_teams.map {|game_team| game_team.head_coach}.uniq
  end

  def create_hash_with_team_games_by_coach(season_id)
    all_coaches.reduce({}) do |coaches_with_games, coach|
      coaches_with_games[coach] = game_teams_that_season_by_coach(coach, season_id)
      coaches_with_games
    end
  end

  def game_teams_that_season_by_coach(coach, season_id)
    @game_teams.find_all do |game_team|
      gameid_of_games_that_season(season_id).include?(game_team.game_id) && game_team.head_coach == coach
    end
  end

  def finding_all_wins_by_coach(season_id)
    create_hash_with_team_games_by_coach(season_id).transform_values do |game_teams|
      (game_teams.find_all {|game| game.result == "WIN"}).length
    end
  end

  def number_of_games_by_coach(season_id)
    create_hash_with_team_games_by_coach(season_id).transform_values do |game_teams|
      game_teams.length
    end
  end

  def percent_wins_by_coach(season_id)
    percent_wins = {}
    finding_all_wins_by_coach(season_id).map do |coach, num_wins|
      percent_wins[coach] = (num_wins.to_f / number_of_games_by_coach(season_id)[coach]).round(2)
    end
    percent_wins
  end

  def winningest_coach(season_id)
    most_wins = percent_wins_by_coach(season_id).max_by {|coach, percent| percent}
    most_wins[0]
  end

  def worst_coach(season_id)
    least_wins = percent_wins_by_coach(season_id).min_by {|coach, percent| percent}
    least_wins[0]
  end


end
