module SeasonStatistcs


  def game_teams_that_season(team_id, season_id)
    @game_teams.find_all do |game_team|
      game_team.game_id.to_s[0..3] == season_id.to_s[0..3] && game_team.team_id == team_id
    end
  end

  def goals_to_shots_ratio_that_season(team_id, season_id)
    all_games = game_teams_that_season(team_id, season_id)
    all_goals = all_games.sum {|game_team| game_team.goals}
    all_shots = all_games.sum{|game_team| game_team.shots}
    (all_goals.to_f / all_shots).round(5)
  end

  def most_accurate_team(season_id)
    teams_with_goals_to_shots_ratio = {}
    all_teams_playing.each do |team_id|
      teams_with_goals_to_shots_ratio[team_id] = goals_to_shots_ratio_that_season(team_id, season_id)
    end
    teams_with_goals_to_shots_ratio.delete_if { |id, ratio| ratio.nil? || ratio.nan?}
    highest = teams_with_goals_to_shots_ratio.max_by {|id, ratio| ratio}
    find_team_names(highest[0])
  end

  def least_accurate_team(season_id)
    teams_with_goals_to_shots_ratio = {}
    all_teams_playing.each do |team_id|
      teams_with_goals_to_shots_ratio[team_id] = goals_to_shots_ratio_that_season(team_id, season_id)
    end
    teams_with_goals_to_shots_ratio.delete_if { |id, ratio| ratio.nil? || ratio.nan?}
    lowest = teams_with_goals_to_shots_ratio.min_by {|id, ratio| ratio}
    find_team_names(lowest[0])
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
      game_team.game_id.to_s[0..3] == season_id.to_s[0..3] && game_team.head_coach == coach
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
    percent_wins_with_active_coaches = percent_wins_by_coach(season_id).delete_if {|coach, wins| wins.nan?}
    most_wins = percent_wins_with_active_coaches.max_by {|coach, percent| percent}
    most_wins[0]
  end

  def worst_coach(season_id)
    percent_wins_with_active_coaches = percent_wins_by_coach(season_id).delete_if {|coach, wins| wins.nan?}
    least_wins = percent_wins_with_active_coaches.min_by {|coach, percent| percent}
    least_wins[0]
  end


end
