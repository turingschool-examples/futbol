require_relative './findable.rb'

class Team
  include Findable
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def team_info(id)
    info = {}
    team = @teams.find do |row|
      row[:team_id] == id
    end
    info["team_id"] = team[:team_id]
    info["franchise_id"] = team[:franchiseid]
    info["team_name"] = team[:teamname]
    info["abbreviation"] = team[:abbreviation]
    info["link"] = team[:link]
    info
  end

  def best_season(team_id)
    season_stats = {}
    all_seasons_played(team_id).each do |season_id|
      season_stats[season_id] = avg_wins_by_season(team_id, season_id)
    end

    best = season_stats.max_by do |season, avg|
      avg
    end
    best[0]
  end

  def worst_season(team_id)
    season_stats = {}
    all_seasons_played(team_id).each do |season_id|
      season_stats[season_id] = avg_wins_by_season(team_id, season_id)
    end
    worst = season_stats.min_by do |season, avg|
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
      end
    end
    (wins.to_f / games_played_in_season(team_id, season_id).count).round(2)
  end

  def games_played_in_season(team_id, season_id)
    game_ids = []
    @games.each do |row|
      if row[:season] == season_id && (row[:away_team_id] == team_id || row[:home_team_id] == team_id)
        game_ids << row[:game_id]
      end
    end
    games_played = []
    @game_teams.each do |row|
      game_ids.each do |id|
        if row[:game_id] == id && row[:team_id] == team_id
          games_played << row
        end
      end
    end
    games_played
  end

  def average_win_percentage(team_id)
    all_games = all_games_played(team_id)
    num_wins = all_games.count do |row|
      row[:result] == "WIN"
    end
    (num_wins.to_f / all_games.count).round(2)
  end

  def all_games_played(team_id)
    @game_teams.select do |row|
      row[:team_id] == team_id
    end
  end

  def most_goals_scored(team_id)
    most_goals = all_games_played(team_id).max_by do |row|
      row[:goals].to_i
    end
    most_goals[:goals].to_i
  end

  def fewest_goals_scored(team_id)
    least_goals = all_games_played(team_id).min_by do |row|
      row[:goals].to_i
    end
    least_goals[:goals].to_i
  end

  def favorite_opponent(team_id)
    fave_team = opponent_rundown(team_id).min_by do |team_name, wins_against|
      wins_against
    end
    fave_team[0]
  end

  def rival(team_id)
    rival_team = opponent_rundown(team_id).max_by do |team_name, wins_against|
      wins_against
    end
    rival_team[0]
  end

  def all_games_against(team_id, opponent_id)
    all_team_games = all_games_played(team_id)
    game_ids = all_team_games.map do |row|
      row[:game_id]
    end
    games_against = []
    @game_teams.each do |row|
      game_ids.each do |game_id|
        if row[:team_id] == opponent_id && row[:game_id] == game_id
          games_against << row
        end
      end
    end
    games_against
  end

  def win_against_rate(team_id, opponent_id)
    games_played = all_games_against(team_id, opponent_id)
    opponent_wins = games_played.count do |row|
      row[:result] == "WIN"
    end
    opponent_wins.to_f / games_played.count
  end

  def all_opponents(team_id)
    all_games = @games.select do |row|
      row if row[:home_team_id] == team_id || row[:away_team_id]
    end
    opponent_ids = []
    all_games.each do |row|
      if row[:away_team_id] == team_id
        opponent_ids << row[:home_team_id]
      elsif row[:home_team_id] == team_id
        opponent_ids << row[:away_team_id]
      end
    end
    opponent_ids.uniq.sort_by { |x| x.to_i }
  end

  def find_name(team_id)
    # team_row = @teams.find do |row|
    #   row[:team_id] == team_id
    # end
    # team_row[:teamname]
    team = find_in_sheet(team_id, :team_id, @teams)
    team[0][:teamname]
  end

  def opponent_rundown(team_id)
    rundown = {}
    all_opponents(team_id).each do |opponent_id|
      rundown[find_name(opponent_id)] =
      win_against_rate(team_id, opponent_id)
    end
    rundown
  end

  def season_finder(game_id)
    # game = @games.find do |row|
    #   game_id == row[:game_id]
    # end
    game = find_in_sheet(game_id, :game_id, @games)
    game[0][:season]
  end
end
