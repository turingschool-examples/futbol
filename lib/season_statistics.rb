class SeasonStatistics
  attr_reader :locations,
              :teams_data,
              :game_data,
              :game_team_data
              
  def initialize(locations)
    @locations = locations
    @game_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    @teams_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    @game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
  end

  def winningest_coach(season_id)
    season_games = find_season_games(season_id)

    season_game_teams = find_season_game_teams(season_games)

    winning_games = Hash.new(0)
    games_played = Hash.new(0)

    season_game_teams.each do |row|
      if row[:result] == "WIN"
        winning_games[row[:team_id]] += 1
        games_played[row[:team_id]] += 1
      elsif row[:result] == "LOSS"
        winning_games[row[:team_id]] = 0
        games_played[row[:team_id]] += 1
      end
    end

    win_percentage = Hash.new(0)

    successful_team = winning_games.max_by do |team, games_won|
        (games_won/games_played[team] * 100).to_f
    end

    @game_team_data.rewind #fix?

    coach_name = ""
    
    @game_team_data.each do |row|
      coach_name = row[:head_coach] if row[:team_id] == successful_team[0]
    end

    coach_name
  end

  def worst_coach(season_id)
    season_games = find_season_games(season_id)

    season_game_teams = find_season_game_teams(season_games)

    winning_games = Hash.new(0)
    games_played = Hash.new(0)

    season_game_teams.each do |row|
      if row[:result] == "WIN"
        winning_games[row[:team_id]] += 1
        games_played[row[:team_id]] += 1
      elsif row[:result] == "LOSS"
        winning_games[row[:team_id]] = 0
        games_played[row[:team_id]] += 1
      end
    end

    win_percentage = Hash.new(0)

    losing_team = winning_games.min_by do |team, games_won|
        (games_won/games_played[team] * 100).to_f
    end

    @game_team_data.rewind

    coach_name = ""
    
    @game_team_data.each do |row|
      coach_name = row[:head_coach] if row[:team_id] == losing_team[0]
    end

    coach_name
  end

  def most_accurate_team(season_id)
    season_games = find_season_games(season_id)

    season_game_teams = find_season_game_teams(season_games)

    goals = Hash.new(0)
    shots = Hash.new(0)

    season_game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    accurate_team = goals.max_by do |team, goals|
      (goals/shots[team] * 100)
    end

    team = @teams_data.find do |row|
      row[:team_id] == accurate_team[0]
    end[:teamname]
  end

  def least_accurate_team(season_id)
    season_games = find_season_games(season_id)

    season_game_teams = find_season_game_teams(season_games)

    goals = Hash.new(0)
    shots = Hash.new(0)

    season_game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    least_accurate_team = goals.min_by do |team, goals|
      (goals/shots[team] * 100)
    end

    team = @teams_data.find do |row|
      row[:team_id] == least_accurate_team[0]
    end[:teamname]
  end

  def most_tackles(season_id)
    season_games = find_season_games(season_id)

    season_game_teams = find_season_game_teams(season_games)

    tackles = Hash.new(0)
    
    season_game_teams.each do |game|
      tackles[game[:team_id]] += game[:tackles].to_f
    end
    
    team = @teams_data.find do |row|
      row[:team_id] == tackles.max[0]
    end[:teamname]
  end

  def least_tackles(season_id)
    season_games = find_season_games(season_id)

    season_game_teams = find_season_game_teams(season_games)

    tackles = Hash.new(0)
    
    season_game_teams.each do |game|
      tackles[game[:team_id]] += game[:tackles].to_f
    end
    
    team = @teams_data.find do |row|
      row[:team_id] == tackles.min[0]
    end[:teamname]
  end

  def find_season_games(season_id)
    season_games = []

    @game_data.each do |row|
      if row[:season] == season_id
        season_games << row
      end
    end

    season_games
  end

  def find_season_game_teams(season_games)
    season_game_teams = []

    @game_team_data.each do |row|
      season_games.each do |game|
        if game[:game_id] == row[:game_id]
          season_game_teams << row
        end
      end
    end

    season_game_teams
  end
end