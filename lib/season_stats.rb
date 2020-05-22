require_relative "stats"

class SeasonStats < Stats

  def most_accurate_team(season)
    team_performances = team_games_by_season(season)
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_accuracy = performance_by_team.transform_values do |team|
      team.sum {|game| game.goals}.to_f / team.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == team_accuracy.max_by {|team, acc| acc}[0]}.team_name
  end

  def least_accurate_team(season)
    team_performances = team_games_by_season(season)
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_accuracy = performance_by_team.transform_values do |team|
      team.sum {|game| game.goals}.to_f / team.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == team_accuracy.min_by {|team, acc| acc}[0]}.team_name
  end

  def winningest_coach(season)
    team_performances = team_games_by_season(season)
    games_by_coach = team_performances.group_by{|team| team.head_coach}
    wins_by_coach = games_by_coach.transform_values do |team|
      team.find_all {|game| game.result == "WIN"}.length
    end
    wins_by_coach.max_by {|coach, wins| wins}[0]
  end

  def worst_coach(season)
    team_performances = team_games_by_season(season)
    games_by_coach = team_performances.group_by{|team| team.head_coach}
    wins_by_coach = games_by_coach.transform_values do |team|
      team.find_all {|game| game.result == "WIN"}.length
    end
    wins_by_coach.min_by {|coach, wins| wins}[0]
  end

  def most_tackles(season)
    team_performances = team_games_by_season(season)
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_tackles = performance_by_team.transform_values do |team|
      team.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == team_tackles.max_by {|team, tack| tack}[0]}.team_name
  end

  def fewest_tackles(season)
    team_performances = team_games_by_season(season)
    performance_by_team = team_performances.group_by{|team| team.team_id}
    team_tackles = performance_by_team.transform_values do |team|
      team.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == team_tackles.min_by {|team, tack| tack}[0]}.team_name
  end

  def team_games_by_season(season)
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
  end

end
