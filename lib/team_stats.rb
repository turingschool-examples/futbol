module TeamStats
  def team_info(id)
    info = {}
    team = @teams.find { |team_row| team_row[:team_id] == id}
    info['team_id'] = team[:team_id]
    info['franchise_id'] = team[:franchiseid]
    info['team_name'] = team[:teamname]
    info['abbreviation'] = team[:abbreviation]
    info['link'] = team[:link]
    info
  end

  def best_season(team_id)
    all_games = @game_teams.find_all{ |game| game[:team_id] == team_id }
    games_by_season = all_games.group_by { |game| game[:game_id][0..3]}
    best_season = games_by_season.max_by do |season, games|
      games.count { |game| game[:result] == 'WIN'} / games.length.to_f
    end[0]
    "#{best_season}#{best_season.next}"
  end

  def worst_season(team_id)
    all_games = @game_teams.find_all{ |game| game[:team_id] == team_id }
    games_by_season = all_games.group_by { |game| game[:game_id][0..3]}
    best_season = games_by_season.min_by do |season, games|
      games.count { |game| game[:result] == 'WIN'} / games.length.to_f
    end[0]
    "#{best_season}#{best_season.next}"
  end

  def average_win_percentage(team_id)
    games_played = @game_teams.count { |row| row[:team_id] == team_id.to_s }
    games_won = @game_teams.count { |row| row[:team_id] == team_id.to_s && row[:result] == 'WIN'}
    (games_won.to_f / games_played).round(2)
  end

  def most_goals_scored(team_id) # mm
    # find all games for team_id, turn them into the goals scored, grab the max, 2 eyes
    @game_teams.find_all { |x| x[:team_id] == team_id.to_s }.map { |x| x[:goals] }.max.to_i
  end

  def fewest_goals_scored(team_id) ## mm
    # find all games for team_id, turn them into the goals scored, grab the min, 2 eyes
    @game_teams.find_all { |x| x[:team_id] == team_id.to_s }.map { |x| x[:goals] }.min.to_i
  end

  def favorite_opponent(team_id)
    record_by_team = Hash.new { |h,k| h[k] = [] }
    @games.each do |game|
      next if game[:away_team_id] != team_id && game[:home_team_id] != team_id
      if game[:away_team_id] == team_id && game[:away_goals] > game[:home_goals] || game[:home_team_id] == team_id && game[:home_goals] > game[:away_goals]
        record_by_team[[game[:away_team_id], game[:home_team_id]].find { |team| team != team_id }] << 'win'
      else
        record_by_team[[game[:away_team_id], game[:home_team_id]].find { |team| team != team_id }] << 'loss'
      end
    end
    opp_id = record_by_team.max_by { |team, results| results.count { |result| result == 'win'} / results.length.to_f }[0]
    team_finder(opp_id)
  end

  def rival(team_id)
    record_by_team = Hash.new { |h,k| h[k] = [] }
    @games.each do |game|
      next if game[:away_team_id] != team_id && game[:home_team_id] != team_id
      if game[:away_team_id] == team_id && game[:away_goals] > game[:home_goals] || game[:home_team_id] == team_id && game[:home_goals] > game[:away_goals]
        record_by_team[[game[:away_team_id], game[:home_team_id]].find { |team| team != team_id }] << 'win'
      else
        record_by_team[[game[:away_team_id], game[:home_team_id]].find { |team| team != team_id }] << 'loss'
      end
    end
    opp_id = record_by_team.min_by { |team, results| results.count { |result| result == 'win'} / results.length.to_f }[0]
    team_finder(opp_id)
  end
end
