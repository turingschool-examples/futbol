class Team
  def initialize
  end

  def team_info(id, teams_data)#Team Stats
    h = {}
    team = teams_data.find do |row|
      row[:team_id] == id
    end
    h["Team ID"] = team[:team_id]
    h["Franchise ID"] = team[:franchiseid]
    h["Team Name"] = team[:teamname]
    h["Abbreviation"] = team[:abbreviation]
    h["Link"] = team[:link]
    h
  end

  def best_season(team_id, games_data, game_teams_data) #Team Stats
    h = {}
    all_seasons_played(team_id, games_data, game_teams_data).each do |season_id|
      h[season_id] = avg_wins_by_season(team_id, season_id, games_data, game_teams_data)
    end

    best = h.max_by do |season, avg|
      avg
    end
    best[0]
  end

  def all_seasons_played(team_id, games_data, game_teams_data) #Team Stats
    seasons_played = []
    games_data.map do |row|
      if row[:away_team_id] == team_id || row[:home_team_id] == team_id
        seasons_played << row[:season]
      end
    end
    seasons_played.uniq
  end

  def avg_wins_by_season(team_id, season_id, games_data, game_teams_data) #Team Stats
    wins = 0
    games = games_played_in_season(team_id, season_id, games_data, game_teams_data)
    games.each do |game|
      if game[:result] == "WIN"
        wins += 1
      elsif game[:result] == "TIE"
        wins += 0.5
      end
    end
    wins / games_played_in_season(team_id, season_id, games_data, game_teams_data).count
  end

  def games_played_in_season(team_id, season_id, games_data, game_teams_data) #Teams Stats
    game_ids = []
    games_data.each do |row|
      if row[:season] == season_id && (row[:away_team_id] == team_id || row[:home_team_id] == team_id)
        game_ids << row[:game_id]
      end
    end
    csv_games = []
    game_teams_data.each do |row|
      game_ids.each do |id|
        if row[:game_id] == id && row[:team_id] == team_id
          csv_games << row
        end
      end
    end
    csv_games
  end

  # def season_finder(game_id) #Team Stats
  #   game = @games.find do |row|
  #     game_id == row[:game_id]
  #   end
  #   game[:season]
  # end
end
