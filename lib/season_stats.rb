module SeasonStatistics
  def find_season(season_id)
    games = []
    @game_teams.each do |row|
      games << row if row[:game_id][0, 4] == season_id[0,4]
    end
    games
  end

  def total_goals(season_id)
    t_goals = Hash.new(0)
    self.find_season(season_id).each do |row|
      if !t_goals.key?(row[:team_id])
        t_goals[row[:team_id]] = row[:goals].to_f
      else
        t_goals[row[:team_id]] += row[:goals].to_f
      end
    end
    t_goals
  end

  def total_shots(season_id)
    t_shots = Hash.new(0)
    self.find_season(season_id).each do |row|
      if !t_shots.key?(row[:team_id])
        t_shots[row[:team_id]] = row[:shots].to_f
      else
        t_shots[row[:team_id]] += row[:shots].to_f
      end
    end
    t_shots
  end

  def most_accurate_team(season_id)
    total_shots = total_shots(season_id)
    total_goals = total_goals(season_id)

    shots_and_goals = total_shots.values.zip(total_goals.values)
    shots_to_goals_ratio = shots_and_goals.map {|array| array[1] / array[0]}

    ratio_hash = Hash[total_shots.keys.zip(shots_to_goals_ratio)]
    most_accurate = ratio_hash.max_by {|team_id, ratio| ratio}
    team_name(most_accurate[0].to_i)
  end

  def least_accurate_team(season_id)
    total_shots = total_shots(season_id)
    total_goals = total_goals(season_id)

    shots_and_goals = total_shots.values.zip(total_goals.values)
    shots_to_goals_ratio = shots_and_goals.map {|array| array[1] / array[0]}

    ratio_hash = Hash[total_shots.keys.zip(shots_to_goals_ratio)]
    most_accurate = ratio_hash.min_by {|team_id, ratio| ratio}
    team_name(most_accurate[0].to_i)
  end
  
  def total_games_played_per_team(season)
  game_tally = Hash.new(0)
  @game_teams.map do |row|
    if row[:game_id][0..3] == season[0..3]
      game_tally[row[:head_coach]] += 1
    end
  end
  game_tally
  end
  
  def total_wins_per_team(season)
  team_wins_hash = Hash.new(0)
  @game_teams.map do |row|
    if row[:game_id][0..3] == season[0..3] && row[:result] == "WIN"
      team_wins_hash[row[:head_coach]] += 1
    end
  end
  team_wins_hash
  end
  
  def winningest_coach(season)
    team_season_wins = total_wins_per_team(season)
    team_total_season_games = total_games_played_per_team(season)
    missing_coaches = team_total_season_games.keys - team_season_wins.keys
    act_total_wins = missing_coaches.map do |coach|
      team_season_wins[coach] = 0
    end
    team_season_wins = team_season_wins.sort.to_h
    team_total_season_games = team_total_season_games.sort.to_h
    nested_arr = team_season_wins.values.zip(team_total_season_games.values)
    win_percent = nested_arr.map do |array|
      array[0].to_f / array[1]
    end
    win_percent_hash = Hash[team_total_season_games.keys.zip(win_percent)]
    winningest = win_percent_hash.max_by {|key, value| value}
    winningest[0].to_s
  end

def worst_coach(season)
  team_season_wins = total_wins_per_team(season)
  team_total_season_games = total_games_played_per_team(season)
  missing_coaches = team_total_season_games.keys - team_season_wins.keys
  act_total_wins = missing_coaches.map do |coach|
    team_season_wins[coach] = 0
  end
  team_season_wins = team_season_wins.sort.to_h
  team_total_season_games = team_total_season_games.sort.to_h
  nested_arr = team_season_wins.values.zip(team_total_season_games.values)
    win_percent = nested_arr.map do |array|
      array[0].to_f / array[1]
    end
  win_percent_hash = Hash[team_total_season_games.keys.zip(win_percent)]
  worst = win_percent_hash.min_by {|key, value| value}
  worst[0].to_s
end

def most_tackles(season)
    tackles_hash = Hash.new(0)
    @game_teams.map do |row|
      if row[:game_id][0..3] == season[0..3]
        tackles_hash[row[:team_id]] += row[:tackles].to_i
      end
    end
    most = tackles_hash.max_by {|team_id, tackles| tackles}
    team_name(most[0].to_i)
  end

  def fewest_tackles(season)
    tackles_hash = Hash.new(0)
    @game_teams.map do |row|
      if row[:game_id][0..3] == season[0..3]
        tackles_hash[row[:team_id]] += row[:tackles].to_i
      end
    end
    least = tackles_hash.min_by {|team_id, tackles| tackles}
    team_name(least[0].to_i)
  end
end