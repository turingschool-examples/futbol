require 'CSV'
require_relative './game_team'

class GameTeamManager
  attr_reader :game_teams

  def initialize(file_path)
    @file_path = file_path
    @game_teams = {}
    load
  end

  def load
    data = CSV.read(@file_path, headers: true)
    data.each do |row|
      if @game_teams[row["game_id"]].nil?
        @game_teams[row["game_id"]] = {away: GameTeam.new(row)}
      else
        @game_teams[row["game_id"]][:home] = GameTeam.new(row)
      end
    end
  end

  def total_games_all_seasons(team_id)
    total = 0
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, team|
        total += 1 if team_id == team.team_id
      end
    end
    total
  end

  def total_goals_all_seasons(team_id)
    total = 0
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, team|
        total += team.goals.to_i if team_id == team.team_id
      end
    end
    total
  end

  def average_goals_all_seasons(team_id)
    average = total_goals_all_seasons(team_id) / total_games_all_seasons(team_id).to_f
    average.round(2)
  end

  def best_offense(teams_by_id)
    best_average = 0
    best_team = nil
    teams_by_id.each do |team_id, team_name|
      average = average_goals_all_seasons(team_id)
      if average > best_average
        best_average = average
        best_team = team_name
      end
    end
    best_team
  end

  def worst_offense(teams_by_id)
    worst_average = 100000
    worst_team = nil
    teams_by_id.each do |team_id, team_name|
      average = average_goals_all_seasons(team_id)
      if average < worst_average
        worst_average = average
        worst_team = team_name
      end
    end
    worst_team
  end

  #######################################
  def highest_scoring_visitor(teams_by_id)
    max = away_teams.max_by do |team|
      games = away_games(team.team_id)
      average_goals(games)
    end
    id = max.team_id
    teams_by_id[id]
  end

  def highest_scoring_home_team(teams_by_id)
    max = home_teams.max_by do |team|
      games = home_games(team.team_id)
      average_goals(games)
    end
    id = max.team_id
    teams_by_id[id]
  end

  def lowest_scoring_visitor(teams_by_id)
    min = away_teams.min_by do |team|
      games = away_games(team.team_id)
      average_goals(games)
    end
    id = min.team_id
    teams_by_id[id]
  end

  def lowest_scoring_home_team(teams_by_id)
    min = home_teams.min_by do |team|
      games = home_games(team.team_id)
      average_goals(games)
    end
    id = min.team_id
    teams_by_id[id]
  end

  def home_teams
    home_teams = []
    @game_teams.each do |game_id, teams|
      home_teams << teams[:home]
    end
    home_teams
  end

  def away_teams
    away_teams = []
    @game_teams.each do |game_id, teams|
      away_teams << teams[:away]
    end
    away_teams
  end

  def home_games(team_id)
    games = []
    home_teams.each do |team|
      games << team if team_id == team.team_id
    end
    games
  end

  def away_games(team_id)
    games = []
    away_teams.each do |team|
      games << team if team_id == team.team_id
    end
    games
  end

  def all_games_by_team(team_id)
    games = []
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, team|
        games << team if team_id == team.team_id
      end
    end
    games
  end

  def average_goals(games)
    goals(games) / games(games).to_f
  end

  def goals(games)
    goals = 0
    games.each do |game|
      goals += game.goals.to_i
    end
    goals
  end

  def games(games)
    games.count
  end

  def average_win_percentage(team_id)
    total_games = 0
    total_wins = 0
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, team|
        if team.team_id == team_id
          if team.result == "WIN"
            total_wins += 1
          end
          total_games += 1
        end
      end
    end
    (total_wins / total_games.to_f).round(2)
  end

  def most_goals_scored(team_id)
    games = all_games_by_team(team_id)
    max = games.max_by do |game|
      game.goals
    end
    max.goals.to_i
  end

  def fewest_goals_scored(team_id)
    games = all_games_by_team(team_id)
    min = games.min_by do |game|
      game.goals
    end
    min.goals.to_i
  end

  def opponent_results
    {games: 0, wins: 0}
  end

  def opponents_list(team_id)
    list = {}
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, team|
        if team.team_id == team_id
          if team.hoa == "home"
            id = teams[:away].team_id
            list[id] ||= opponent_results
            list[id][:games] += 1
            list[id][:wins] += 1 if teams[:away].result == 'WIN'
          elsif team.hoa == "away"
            id = teams[:home].team_id
            list[id] ||= opponent_results
            list[id][:games] += 1
            list[id][:wins] += 1 if teams[:home].result == 'WIN'
          end
        end
      end
    end
    list
  end

  # Edge case question: What to do if a team never wins?
  def favorite_opponent(team_id)
    favorite = nil
    highest = 2013020002
    op_hash = opponents_list(team_id)
    op_hash.each do |opponent_id, results|
      current = results[:wins] / results[:games].to_f
      if current < highest
        highest = current
        favorite = opponent_id
      end
    end
    favorite
  end

  def rival(team_id)
    arch_nemesis = nil
    lowest = 0
    op_hash = opponents_list(team_id)
    op_hash.each do |opponent_id, results|
      current = results[:wins] / results[:games].to_f
      if current > lowest
        lowest = current
        arch_nemesis = opponent_id
      end
    end
    arch_nemesis
  end

end
