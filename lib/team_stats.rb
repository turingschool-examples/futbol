module TeamStatistics
  def team_info(team_id)
    team_hash = Hash.new
    @teams.map do |row|
      if row[:team_id] == team_id
        team_hash["team_id"] = row[:team_id]
        team_hash["franchise_id"] = row[:franchiseid]
        team_hash["team_name"] = row[:teamname]
        team_hash["abbreviation"] = row[:abbreviation]
        team_hash["link"] = row[:link]
      end
    end
    team_hash
  end

  def total_wins_per_season(team_id)
    season_wins = Hash.new(0)
    @games.map do |row|
      if row[:home_team_id] == team_id && row[:home_goals] > row[:away_goals]
        season_wins[row[:season]] += 1
      elsif row[:away_team_id] == team_id && row[:away_goals] > row[:home_goals]
        season_wins[row[:season]] += 1
      end
    end
    season_wins
  end

  def total_games_played_per_season(team_id)
    season_tally = Hash.new(0)
    @games.map do |row|
      if row[:home_team_id] == team_id || row[:away_team_id] == team_id
        season_tally[row[:season]] += 1
      end
    end
    season_tally
  end

  def best_season(team_id)
    season_wins = total_wins_per_season(team_id)
    games_played = total_games_played_per_season(team_id)

    nested_arr = season_wins.values.zip(games_played.values)
    divide_wins_to_games = nested_arr.map {|array| array[0].to_f / array[1]}
    percentages_hash = Hash[games_played.keys.zip(divide_wins_to_games)]
    best = percentages_hash.max_by {|key,value| value}
    best[0]
  end

  def worst_season(team_id)
    season_wins = total_wins_per_season(team_id)
    games_played = total_games_played_per_season(team_id)

    nested_arr = season_wins.values.zip(games_played.values)
    divide_wins_to_games = nested_arr.map {|array| array[0].to_f / array[1]}
    percentages_hash = Hash[games_played.keys.zip(divide_wins_to_games)]
    best = percentages_hash.min_by {|key,value| value}
    best[0]
  end

  def total_games_played(team_id)
    all_games = 0
    @games.filter_map {|row| all_games += 1 if row[:home_team_id] == team_id || row[:away_team_id] == team_id}
    all_games
  end

  def average_win_percentage(team_id)
    total_wins = total_wins_per_season(team_id).values.sum.to_f
    (total_wins / total_games_played(team_id)).round(2)
  end

  def most_goals_scored(team_id)
    most_goals = []
    @game_teams.map do |row|
      if row[:team_id] == team_id
        most_goals << row[:goals]
      end
    end
    most_goals.max.to_i
  end

  def fewest_goals_scored(team_id)
    fewest_goals = []
    @game_teams.map do |row|
      if row[:team_id] == team_id
        fewest_goals << row[:goals]
      end
    end
    fewest_goals.min.to_i
  end

  def total_times_won_against(team_id)
    teams_win_count = Hash.new(0)
    @games.map do |row|
      if row[:away_team_id] == team_id && row[:away_goals] < row[:home_goals]
        teams_win_count[row[:home_team_id].to_i] += 1
      elsif row[:home_team_id] == team_id && row[:home_goals] < row[:away_goals]
        teams_win_count[row[:away_team_id].to_i] += 1
      end
    end
    sorted_wins = teams_win_count.sort.to_h
    sorted_wins
  end

  def total_times_played_against(team_id)
    total_times_played = Hash.new(0)
    @games.map do |row|
      if row[:home_team_id] == team_id
        total_times_played[row[:away_team_id].to_i] += 1
      elsif row[:away_team_id] == team_id
        total_times_played[row[:home_team_id].to_i] += 1
      end
    end
    sorted_times_played = total_times_played.sort.to_h
    sorted_times_played
  end

  def favorite_opponent(team_id)
    wins = total_times_won_against(team_id)
    total_games = total_times_played_against(team_id)

    lol = total_games.keys - wins.keys
    lol.map {|team| wins[team] = 0}
    wins = wins.sort.to_h

    wins_and_totals = wins.values.zip(total_games.values)
    percentage_wins = wins_and_totals.map {|array| array[0].to_f / array[1]}

    hash_percentages = Hash[wins.keys.zip(percentage_wins)]
    won_least = hash_percentages.min_by {|key,value| value}
    fav_oppt = team_name(won_least[0].to_i)
    return fav_oppt
  end

  def rival(team_id)
    wins = total_times_won_against(team_id)
    total_games = total_times_played_against(team_id)

    lol = total_games.keys - wins.keys
    lol.map {|team| wins[team] = 0}
    wins = wins.sort.to_h

    wins_and_totals = wins.values.zip(total_games.values)
    percentage_wins = wins_and_totals.map {|array| array[0].to_f / array[1]}
    hash_percentages = Hash[wins.keys.zip(percentage_wins)]
    won_most = hash_percentages.max_by {|key,value| value}
    least_fav_oppt = team_name(won_most[0].to_i)
    return least_fav_oppt
  end
end
