class Team
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def team_info(id) #stat_tracker
    h = {}
    team = @teams.find do |row|
      row[:team_id] == id
    end
    h["Team ID"] = team[:team_id]
    h["Franchise ID"] = team[:franchiseid]
    h["Team Name"] = team[:teamname]
    h["Abbreviation"] = team[:abbreviation]
    h["Link"] = team[:link]
    h
  end

  def best_season(team_id) #stat_tracker
    h = {}
    all_seasons_played(team_id).each do |season_id|
      h[season_id] = avg_wins_by_season(team_id, season_id)
    end

    best = h.max_by do |season, avg|
      avg
    end
    best[0]
  end

  def worst_season(team_id) #stat_tracker
    h = {}
    all_seasons_played(team_id).each do |season_id|
      h[season_id] = avg_wins_by_season(team_id, season_id)
    end

    worst = h.min_by do |season, avg|
      avg
    end
    worst[0]
  end

  def all_seasons_played(team_id)
    seasons_played = []
    @games.map do |row|
      if row[:away_team_id] == team_id || row[:home_team_id] == team_id
        seasons_played << row[:season]
      end
    end
    seasons_played.uniq
  end

  def avg_wins_by_season(team_id, season_id)
    wins = 0
    games = games_played_in_season(team_id, season_id)
    games.each do |game|
      if game[:result] == "WIN"
        wins += 1
      elsif game[:result] == "TIE"
        wins += 0.5
      end
    end
    wins / games_played_in_season(team_id, season_id).count
  end

  def games_played_in_season(team_id, season_id)
    game_ids = []
    @games.each do |row|
      if row[:season] == season_id && (row[:away_team_id] == team_id || row[:home_team_id] == team_id)
        game_ids << row[:game_id]
      end
    end
    csv_games = []
    @game_teams.each do |row|
      game_ids.each do |id|
        if row[:game_id] == id && row[:team_id] == team_id
          csv_games << row
        end
      end
    end
    csv_games
  end

  def average_win_percentage(team_id) #stat_tracker
    all_games = all_games_played(team_id)
    num_wins = all_games.count do |row|
      row[:result] == "WIN"
    end
    (num_wins.to_f / all_games.count * 100 ).round(2)
  end

  def all_games_played(team_id)
    @game_teams.select do |row|
      row if row[:team_id] == team_id
    end
  end

  def most_goals_scored(team_id) #stat tracker
    most_goals = all_games_played(team_id).max_by do |row|
      row[:goals].to_i
    end
    most_goals[:goals].to_i
  end

  def fewest_goals_scored(team_id) #stat tracker
    least_goals = all_games_played(team_id).min_by do |row|
      row[:goals].to_i
    end
    least_goals[:goals].to_i
  end

  def favorite_opponent #stat tracker
  end

  def rival #stat_tracker
  end

  def all_games_against(team_id, opponent_id)
    game_ids = all_games_played(team_id).map do |row|
      row[:game_id]
    end
    x = @game_teams.select do |row|
      row[:team_id] == opponent_id
    end
  end


  def season_finder(game_id)
    game = @games.find do |row|
      game_id == row[:game_id]
    end
    game[:season]
  end
end
