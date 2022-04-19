require './required_files'

module SeasonModule



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
        win_loss.each do |val|
          if val == "WIN"
            wins += 1
          end
        end
        percentage = ((wins.to_f / win_loss.length) * 100).round(2)
        coach_wins_losses[coach] = percentage
    end
    return coach_wins_losses
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

end
