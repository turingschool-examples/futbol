module SeasonStats
  def winningest_coach(season) # mm
    szn = season.to_s[0..3]
    szn_game_results = @game_teams.select { |game| game[:game_id][0..3] == szn }
    # the hash
    coaches_hash = Hash.new { |h, k| h[k] = [] }
    # group the coaches with their results
    szn_game_results.group_by do |csv_row|
      coaches_hash[csv_row[:head_coach]] << csv_row[:result]
    end
    # convert the values to winning percentages
    win_pct = coaches_hash.each do |k, _v|
      # for a given coach, divide wins(float) by total games and round to 3 decimal places
      coaches_hash[k] = (coaches_hash[k].find_all { |x| x == 'WIN' }.count.to_f / coaches_hash[k].count).round(3)
    end
    # win_pct
    # find the best
    winningest = win_pct.max_by { |_k, v| v }
    # return the name
    winningest.first
  end

  def worst_coach(season) # mm
    szn = season.to_s[0..3]
    szn_game_results = @game_teams.select { |game| game[:game_id][0..3] == szn }
    # a hash to be populated
    coaches_hash = Hash.new { |h, k| h[k] = [] }
    # group the coaches with their results arrays
    szn_game_results.group_by do |csv_row|
      coaches_hash[csv_row[:head_coach]] << csv_row[:result]
    end
    # convert the values to winning percentages
    win_pct = coaches_hash.each do |k, _v|
      coaches_hash[k] = (coaches_hash[k].find_all { |x| x == 'WIN' }.count.to_f / coaches_hash[k].count).round(3)
    end
    # find the worst
    worst = win_pct.min_by { |_k, v| v }
    # put him on blast
    worst.first
  end

  def most_accurate_team(season)
    # select games by game_id for a single season
    season_games = @game_teams.select { |game| game[:game_id].start_with?(season[0..3]) }

    # create a hash, with default value as a hash
    team_shots_goals = Hash.new({ shots: 0, goals: 0 })

    season_games.each do |game|
      team_shots_goals.default = { shots: 0, goals: 0 }
      team_shots_goals[game[:team_id]] = {
        shots: team_shots_goals[game[:team_id]][:shots] += game[:shots].to_i,
        goals: team_shots_goals[game[:team_id]][:goals] += game[:goals].to_i
      }
    end
    team_id = team_shots_goals.max_by do |_team, stats|
      stats[:goals].to_f / stats[:shots]
    end
    team_finder(team_id[0])
  end

  def least_accurate_team(season)
    season_games = @game_teams.select { |game| game[:game_id].start_with?(season[0..3]) }

    team_shots_goals = Hash.new({ shots: 0, goals: 0 })
    season_games.each do |game|
      team_shots_goals.default = { shots: 0, goals: 0 }
      team_shots_goals[game[:team_id]] = {
        shots: team_shots_goals[game[:team_id]][:shots] += game[:shots].to_i,
        goals: team_shots_goals[game[:team_id]][:goals] += game[:goals].to_i
      }
    end
    team_id = team_shots_goals.min_by do |_team, stats|
      stats[:goals].to_f / stats[:shots]
    end
    team_finder(team_id[0])
  end

  def most_tackles(season)
    # select games by game_id for a single season
    season_games = @game_teams.select { |game| game[:game_id].start_with?(season[0..3]) }
    # create a new Hash
    team_tackles = Hash.new(0)
    # iterate over the games of the season
    season_games.each do |game|
      # accumulate the tackles, grouped by team_id
      team_tackles[game[:team_id]] += game[:tackles].to_i
    end
    # find the team_id with the fewest tackles
    team_id = team_tackles.max_by { |_team_id, tackles| tackles }
    # use the team_finder helper method to return the team name
    team_finder(team_id[0])
  end

  def fewest_tackles(season)
    # select games by game_id for a single season
    season_games = @game_teams.select { |game| game[:game_id].start_with?(season[0..3]) }
    # create a new hash
    team_tackles = Hash.new(0)
    # iterate over the games of the season
    season_games.each do |game|
      # accumulate the tackles, grouped by team_id
      team_tackles[game[:team_id]] += game[:tackles].to_i
    end
    # find the team_id with the fewest tackles
    team_id = team_tackles.min_by { |_team_id, tackles| tackles }
    # use the team_finder helper method to return the team name
    team_finder(team_id[0])
  end
end
