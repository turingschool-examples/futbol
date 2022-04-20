

module SeasonModule


  def SeasonModule.tackles_hash(season_id, game_teams)
    game_season = []
    game_teams.each do |game|
      if season_id[0..3] == game.game_id[0..3]
        game_season << game
      end
    end
    tackles_hash = {}
    game_season.each do |game|
      if tackles_hash[game.team_id] == nil
        tackles_hash[game.team_id] = game.tackles.to_i
      else
        tackles_hash[game.team_id] += game.tackles.to_i
      end
    end
    tackles_hash
  end
  
  def SeasonModule.game_teams_for_season(season, game_teams)
    game_teams.find_all{|game_team| game_team.game_id[0..3] == season[0..3]}
  end

  def SeasonModule.coach_wins_losses_for_season(game_teams_by_season)
    coach_wins_losses = {}
    game_teams_by_season.each do |game_team|
      if coach_wins_losses.keys.include?(game_team.head_coach)
        coach_wins_losses[game_team.head_coach] << game_team.result
      else
        coach_wins_losses[game_team.head_coach] = [game_team.result]
      end
    end
    return coach_wins_losses
  end

  def SeasonModule.coach_win_percentage(coach_wins_losses)
    coach_wins_losses.each do |coach, win_loss|
        wins = 0
        win_loss.each{|val| wins += 1 if val == "WIN"}
        percentage = ((wins.to_f / win_loss.length) * 100).round(2)
        coach_wins_losses[coach] = percentage
    end
    return coach_wins_losses
  end

  def SeasonModule.best_coach(season, game_teams)
    game_teams_by_season = game_teams_for_season(season, game_teams)
    coach_wins_losses = coach_wins_losses_for_season(game_teams_by_season)
		coach_win_percentages = coach_win_percentage(coach_wins_losses)
		best_coach = coach_win_percentages.invert.max[1]
    return best_coach
  end

  def SeasonModule.worst_coach(season, game_teams)
    game_teams_by_season = game_teams_for_season(season, game_teams)
    coach_wins_losses = coach_wins_losses_for_season(game_teams_by_season)
		coach_win_percentages = coach_win_percentage(coach_wins_losses)
		worst_coach = coach_win_percentages.invert.min[1]
		return worst_coach
  end

  def SeasonModule.team_shots_goals(season_game_teams)
    team_shots_goals = {}
    season_game_teams.each do |season_game|
      team_id = season_game.team_id
      if team_shots_goals[team_id]
        team_shots_goals[team_id][0] += season_game.shots
        team_shots_goals[team_id][1] +=  season_game.goals
      else
        team_shots_goals[team_id] = [season_game.shots, season_game.goals]
      end
    end
    return team_shots_goals
  end

  def SeasonModule.shots_goals_ratio(team_shots_goals)
    shots_goals_ratio = {}
    team_shots_goals.each do |team_id, shots_goals|
      ratio = shots_goals[0].to_f / shots_goals[1].to_f
      shots_goals_ratio[team_id] = ratio
    end
    return shots_goals_ratio
  end

  def SeasonModule.best_team(season, game_teams, teams)
    season_game_teams = game_teams_for_season(season, game_teams)
		team_shots_goals = team_shots_goals(season_game_teams)
		team_shots_goals_ratios = shots_goals_ratio(team_shots_goals)
		best_team_id = team_shots_goals_ratios.invert.min[1]
		best_team = teams.find{|team| team.team_id == best_team_id}
		return best_team.team_name
  end

  def SeasonModule.worst_team(season, game_teams, teams)
    season_game_teams = game_teams_for_season(season, game_teams)
		team_shots_goals = team_shots_goals(season_game_teams)
		team_shots_goals_ratios = shots_goals_ratio(team_shots_goals)
		worst_team_id = team_shots_goals_ratios.invert.max[1]
		worst_team = teams.find{|team| team.team_id == worst_team_id}
		return worst_team.team_name

  end

end
