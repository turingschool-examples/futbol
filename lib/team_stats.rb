modoule TeamStats
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
    wins_hash = Hash.new { |h,k| h[k] = [] }
    all_games_played = @games.find_all { |game| [game[:home_team_id], game[:away_team_id]].include?(team_id) }

    all_games_played.each do |game|
      opponent = [game[:home_team_id], game[:away_team_id]].find{ |team| team != team_id }
      wins_hash[opponent] << game[:game_id]
    end

    wins_hash.each do |opponent, game_ids|
      wins_hash[opponent] = game_ids.map do |game_id|
        row = @game_teams.find { |game| game[:game_id] == game_id && game[:team_id] == team_id.to_s }
        row[:result]
      end
    end

    fave_opp_id = wins_hash.max_by { |key, value| value.count { |result| result == 'WIN'}.to_f / value.length }[0]

    team_finder(fave_opp_id)
  end

  def rival(team_id)
    wins_hash = Hash.new { |h,k| h[k] = [] }
    all_games_played = @games.find_all { |game| [game[:home_team_id], game[:away_team_id]].include?(team_id.to_s) }

    all_games_played.each do |game|
      opponent = [game[:home_team_id], game[:away_team_id]].find{ |team| team != team_id }
      wins_hash[opponent] << game[:game_id]
    end

    wins_hash.each do |key, value|
      wins_hash[key] = value.map do |game_id|
        row = @game_teams.find { |game| game[:game_id] == game_id && game[:team_id] == team_id.to_s }
        row[:result]
      end
    end

    opp_id = wins_hash.min_by { |key, value| value.count { |result| result == 'WIN'}.to_f / value.length }[0]

    team_finder(opp_id)
  end

  # #helper method for best/worst season
  # def find_all_games_for_a_team(team_id)
  #   @games.find_all do |game|
  #    (game[:home_team_id] == team_id) || (game[:away_team_id] == team_id) 
  #   end
  # end
  #  #helper method for best/worst season
  #  def games_grouped_by_season(all_games)
  #    all_games.group_by do |game|
  #      game[:season]
  #    end
  #  end
 
  #  #helper method for best/worst season
  #  def season_game_count(season_games)
  #    game_count = Hash.new(0)
  #    season_games.each do |season, games|
  #      game_count[season] = games.length
  #    end
  #    game_count
  #  end
  #  #helper method for best/worst season
  #  def wins_count(season_games, team_id)
  #    wins_count = Hash.new(0)
  #    season_games.map do |season, games|
  #      games.map do |game|
  #        @game_teams.map do |game_team|
  #          if game_team[:game_id] == game[:game_id] && game_team[:team_id] == team_id && game_team[:result] == "WIN"
  #                wins_count[season] = 1 if wins_count[season].nil?
  #                wins_count[season] += 1 if !wins_count[season].nil?
  #          else 
  #            next
  #          end
  #        end
  #      end
  #    end
  #    wins_count
  #  end
  #  #helper method for best/worst season
  #  def win_percent_by_season(wins_count, season_game_count)
  #    season_game_count.merge(wins_count) do |season, game_count, wins_count|
  #      # binding.pry
  #      ((wins_count.to_f / game_count) * 100).round(2)
  #    end
  #  end
  #  #helper method for best/worst season
  #  def season_win_percentage(win_percent_by_season, use_max)
  #    if use_max
  #      result = win_percent_by_season.max_by do |season, percentage|
  #        percentage
  #      end
  #    else 
  #      result = win_percent_by_season.min_by do |season, percentage|
  #      percentage
  #    end
  #    end
  #    result[0]
  #  end
   
  #  def best_season(team_id)
  #    all_games = find_all_games_for_a_team(team_id)
  #    season_games = games_grouped_by_season(all_games)
  #    season_game_count = season_game_count(season_games)
  #    wins_count = wins_count(season_games, team_id)
  #    win_percent_by_season = win_percent_by_season(wins_count, season_game_count)
  #     season_win_percentage(win_percent_by_season, true)
  #    #  binding.pry
  #  end
 
  #  def worst_season(team_id)
  #    all_games = find_all_games_for_a_team(team_id)
  #    season_games = games_grouped_by_season(all_games)
  #    season_game_count = season_game_count(season_games)
  #    wins_count = wins_count(season_games, team_id)
  #    win_percent_by_season = win_percent_by_season(wins_count, season_game_count)
  #     season_win_percentage(win_percent_by_season, false)
  #  end
end