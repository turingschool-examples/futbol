module SeasonStatable

  def all_season_game_id(season)
    @games.map do |game|
      game.game_id if game.season == season
    end.compact 
  end 

  def winningest_coach(season)
    coach_wins = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|
      if all_season_game_id(season).include?(game.game_id) 
        if game.result == "WIN"
          hash[game.head_coach] = [1 + hash[game.head_coach][0], 1 + hash[game.head_coach][1]]
        else
          hash[game.head_coach] = [hash[game.head_coach][0], 1 + hash[game.head_coach][1]]
        end
      end
    end

    coach_win_percentage = coach_wins.transform_values do |value| 
      (value[0] / value[1].to_f).round(4)
    end

    max_win_percentage = coach_win_percentage.values.max
    coach_win_percentage.key(max_win_percentage)
  end
  
  def worst_coach(season)
    coach_loss = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|
      if all_season_game_id(season).include?(game.game_id) 
        if game.result == "WIN"
          hash[game.head_coach] = [1 + hash[game.head_coach][0], 1 + hash[game.head_coach][1]]
        else
          hash[game.head_coach] = [hash[game.head_coach][0], 1 + hash[game.head_coach][1]]
        end
      end
    end
    coach_loss_percentage = coach_loss.transform_values do |value| 
      (value[0] / value[1].to_f).round(4)
    end

    min_win_percentage = coach_loss_percentage.values.min
    coach_loss_percentage.key(min_win_percentage)
  end

  def avg_goals_made(season)
    goals = @game_teams.each_with_object(Hash.new([0,0])) { |game, hash|
        if all_season_game_id(season).include?(game.game_id)
            hash[game.team_id] = [game.goals + hash[game.team_id][0], game.shots + hash[game.team_id][1]]
        end
    }.transform_values { |value| (value[0] / value[1].to_f).round(4) }
  end

  def most_accurate_team(season)
      avg_goals = avg_goals_made(season)
      team_list[avg_goals.key(avg_goals.values.max)]
  end

  def least_accurate_team(season)
      avg_goals = avg_goals_made(season)
      team_list[avg_goals.key(avg_goals.values.min)]
  end

  def total_tackles_by_team_id(season)
    @game_teams.each_with_object(Hash.new(0)) do |game, hash|
      if all_season_game_id(season).include?(game.game_id)
        hash[game.team_id] += game.tackles.to_i
      end
    end
  end

  def most_tackles(season)
    team_with_most_tackles = total_tackles_by_team_id(season).values.max
    most_tackles = total_tackles_by_team_id(season).key(team_with_most_tackles)
    team_list[most_tackles]
  end

  def fewest_tackles(season)
    team_with_fewest_tackles = total_tackles_by_team_id(season).values.min
    fewest_tackles = total_tackles_by_team_id(season).key(team_with_fewest_tackles)
    team_list[fewest_tackles]
  end
end