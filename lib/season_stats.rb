module SeasonStats
  def winningest_coach(season)
    szn_game_results = game_data_for_a_season(season)
    coaches_hash = Hash.new { |h, k| h[k] = [] }
    szn_game_results.group_by do |csv_row|
      coaches_hash[csv_row[:head_coach]] << csv_row[:result]
    end
    win_pct = coaches_hash.each do |k, _v|
      coaches_hash[k] = (coaches_hash[k].find_all { |x| x == 'WIN' }.count.to_f / coaches_hash[k].count).round(3)
    end
    win_pct.max_by { |_k, v| v }[0]
  end

  def worst_coach(season)
    szn_game_results = game_data_for_a_season(season)
    coaches_hash = Hash.new { |h, k| h[k] = [] }
    szn_game_results.group_by do |csv_row|
      coaches_hash[csv_row[:head_coach]] << csv_row[:result]
    end
    win_pct = coaches_hash.each do |k, _v|
      coaches_hash[k] = (coaches_hash[k].find_all { |x| x == 'WIN' }.count.to_f / coaches_hash[k].count).round(3)
    end
    win_pct.min_by { |_k, v| v }[0]
  end

  def most_accurate_team(season)
    season_games = game_data_for_a_season(season)

    team_id = shots_and_goals_by_team(season_games).max_by do |_team, stats| 
      stats[:goals].to_f / stats[:shots]
    end
    
    team_finder(team_id[0])
  end

  def least_accurate_team(season)
    season_games = game_data_for_a_season(season)

    team_id = shots_and_goals_by_team(season_games).min_by do |_team, stats| 
      stats[:goals].to_f / stats[:shots]
    end

    team_finder(team_id[0])
  end

  def most_tackles(season)
    season_games = game_data_for_a_season(season)
    team_tackles = Hash.new(0)
    season_games.each do |game|
      team_tackles[game[:team_id]] += game[:tackles].to_i
    end
    team_id = team_tackles.max_by { |_team_id, tackles| tackles }
    team_finder(team_id[0])
  end

  def fewest_tackles(season)
    season_games = game_data_for_a_season(season)
    team_tackles = Hash.new(0)
    season_games.each do |game|
      team_tackles[game[:team_id]] += game[:tackles].to_i
    end
    team_id = team_tackles.min_by { |_team_id, tackles| tackles }
    team_finder(team_id[0])
  end

  def game_data_for_a_season(season)
    @game_teams.select { |game| game[:game_id].start_with?(season[0..3]) }
  end

  def shots_and_goals_by_team(season_games)
    team_shots_goals = Hash.new({ shots: 0, goals: 0 })
    season_games.each do |game|
      team_shots_goals.default = { shots: 0, goals: 0 }
      team_shots_goals[game[:team_id]] = {
        shots: team_shots_goals[game[:team_id]][:shots] += game[:shots].to_i,
        goals: team_shots_goals[game[:team_id]][:goals] += game[:goals].to_i
      }
    end
    team_shots_goals
  end
end
