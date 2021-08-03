require 'CSV'
require_relative './game_team'

class GameTeamManager
  attr_reader :game_teams

  def initialize(file_path)
    @file_path = file_path
    @game_teams = load
  end

  def load
    gt_games = Hash.new { |hash, key| hash[key] = { away: nil, home: nil} }
    data = CSV.read(@file_path, headers: true)
    data.each do |row|
      if row["HoA"] == "away"
        gt_games[row["game_id"]][:away] = GameTeam.new(row)
      elsif row["HoA"] == "home"
        gt_games[row["game_id"]][:home] = GameTeam.new(row)
      end
    end
    gt_games
  end

  def total_games_all_seasons(team_id)
    total = 0
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, game_team|
        total += 1 if team_id == game_team.team_id
      end
    end
    total
  end

  def total_goals_all_seasons(team_id)
    total = 0
    @game_teams.each do |game_id, teams|
      teams.each do |hoa, team|
        total += team.goals if team_id == team.team_id
      end
    end
    total
  end

  def average_goals_all_seasons(team_id)
    average = total_goals_all_seasons(team_id).fdiv(total_games_all_seasons(team_id))
    average.round(2)
  end

  def all_team_ids
    ids = []
    @game_teams.each do |game_id, home_and_away|
      home_and_away.each do |hoa, game_team|
        ids << game_team.team_id
      end
    end
    ids.uniq
  end

  def best_offense
    all_team_ids.max_by do |team_id, team_name|
      average_goals_all_seasons(team_id)
    end
  end

  def worst_offense
    all_team_ids.min_by do |team_id, team_name|
      average_goals_all_seasons(team_id)
    end
  end

  def highest_scoring_visitor
    highest_scoring_visitor = away_teams.max_by do |game_team_object|
      away_games_per_team = away_games_per_team(game_team_object.team_id)
      average_goals(away_games_per_team)
    end
    highest_scoring_visitor.team_id
  end

  def highest_scoring_home_team
    highest_scoring_home_team = home_teams.max_by do |game_team_object|
      home_games_per_team = home_games_per_team(game_team_object.team_id)
      average_goals(home_games_per_team)
    end
    highest_scoring_home_team.team_id
  end

  def lowest_scoring_visitor
    lowest_scoring_visitor = away_teams.min_by do |game_team_object|
      away_games_per_team = away_games_per_team(game_team_object.team_id)
      average_goals(away_games_per_team)
    end
    lowest_scoring_visitor.team_id
  end

  def lowest_scoring_home_team
    lowest_scoring_home_team = home_teams.min_by do |game_team_object|
      home_games_per_team = home_games_per_team(game_team_object.team_id)
      average_goals(home_games_per_team)
    end
    lowest_scoring_home_team.team_id
  end

  def home_teams
    home_teams = []
    @game_teams.each do |game_id, game_team_object|
      home_teams << game_team_object[:home]
    end
    home_teams
  end

  def away_teams
    away_teams = []
    @game_teams.each do |game_id, game_team_object|
      away_teams << game_team_object[:away]
    end
    away_teams
  end

  def home_games_per_team(team_id)
    home_games = []
    home_teams.each do |home_team_object|
      home_games << home_team_object if team_id == home_team_object.team_id
    end
    home_games
  end

  def away_games_per_team(team_id)
    away_games = []
    away_teams.each do |away_team_object|
      away_games << away_team_object if team_id == away_team_object.team_id
    end
    away_games
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
    goals(games).fdiv(games_count(games))
  end

  def goals(games)
    goals = 0
    games.each do |game|
      goals += game.goals.to_i
    end
    goals
  end

  def games_count(games)
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
    (total_wins.fdiv(total_games)).round(2)
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

  def opponents_list(team_id)
    list = Hash.new {|h, k| h[k] = {games: 0, wins: 0}}
    @game_teams.each do |game_id, teams|
      if teams[:home].team_id == team_id
        id = teams[:away].team_id
        list[id][:wins] += 1 if teams[:away].result == 'WIN'
        list[id][:games] += 1
      elsif teams[:away].team_id == team_id
        id = teams[:home].team_id
        list[id][:wins] += 1 if teams[:home].result == 'WIN'
        list[id][:games] += 1
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
