require_relative './game_team'
require_relative './manager'
require_relative './mathable'

class GameTeamManager < Manager
  include Mathable
  attr_reader :game_teams

  def initialize(file_path)
    @file_path = file_path
    @game_teams = load(@file_path, GameTeam)
  end

  def total_games_all_seasons(id)
    @game_teams.count do |game_team|
      game_team.team_id == id
    end
  end

  def total_goals_all_seasons(id)
    total = 0
    @game_teams.each do |game_team|
      total += game_team.goals if game_team.team_id == id
    end
    total
  end

  def average_goals_all_seasons(team_id)
    find_percent(total_goals_all_seasons(team_id), total_games_all_seasons(team_id))
  end

  def all_team_ids
    @game_teams.map do |game_team|
      game_team.team_id
    end.uniq
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
      games = away_games_per_team(game_team_object.team_id)
      find_percent(goals_count(games), games_count(games))
    end
    highest_scoring_visitor.team_id
  end

  def highest_scoring_home_team
    highest_scoring_home_team = home_teams.max_by do |game_team_object|
      games = home_games_per_team(game_team_object.team_id)
      find_percent(goals_count(games), games_count(games))
    end
    highest_scoring_home_team.team_id
  end

  def lowest_scoring_visitor
    lowest_scoring_visitor = away_teams.min_by do |game_team_object|
      games = away_games_per_team(game_team_object.team_id)
      find_percent(goals_count(games), games_count(games))
    end
    lowest_scoring_visitor.team_id
  end

  def lowest_scoring_home_team
    lowest_scoring_home_team = home_teams.min_by do |game_team_object|
      games = home_games_per_team(game_team_object.team_id)
      find_percent(goals_count(games), games_count(games))
    end
    lowest_scoring_home_team.team_id
  end

  def home_teams
    @game_teams.find_all do |game_team_object|
      game_team_object.hoa == 'home'
    end
  end

  def away_teams
    @game_teams.find_all do |game_team_object|
      game_team_object.hoa == 'away'
    end
  end

  def home_games_per_team(team_id)
    home_teams.find_all do |home_team_object|
      team_id == home_team_object.team_id
    end
  end

  def away_games_per_team(team_id)
    away_teams.find_all do |away_team_object|
      team_id == away_team_object.team_id
    end
  end

  def all_games_by_team(id)
    @game_teams.find_all do |game_team|
      game_team.team_id == id
    end
  end

  def goals_count(games)
    games.sum do |game|
      game.goals
    end
  end

  def games_count(games)
    games.count
  end

  def average_win_percentage(id)
    total_games = 0
    total_wins = 0
    @game_teams.each do |game_team|
      if game_team.team_id == id
        total_wins += 1 if game_team.result == "WIN"
        total_games += 1
      end
    end
    find_percent(total_wins, total_games)
  end

  def most_goals_scored(team_id)
    max = all_games_by_team(team_id).max_by do |game|
      game.goals
    end
    max.goals
  end

  def fewest_goals_scored(team_id)
    min = all_games_by_team(team_id).min_by do |game|
      game.goals
    end
    min.goals
  end

  def all_game_ids_by_team(team_id)
    game_ids = []
    @game_teams.each do |game_team|
      game_ids << game_team.game_id if game_team.team_id == team_id
    end
    game_ids
  end

  def opponents_list(team_id)
    list = Hash.new { |h, k| h[k] = {games: 0, wins: 0} }
    game_ids = all_game_ids_by_team(team_id)
    @game_teams.each do |game_team|
      game_ids.each do |game_id|
        if game_team.game_id == game_id && game_team.team_id != team_id
          list[game_team.team_id][:games] += 1
          list[game_team.team_id][:wins] += 1 if game_team.result == 'WIN'
        end
      end
    end
    list
  end

  def favorite_opponent(team_id)
    opponents_list(team_id).min_by do |opponent_id, results|
      find_percent(results[:wins], results[:games])
    end.first
  end

  def rival(team_id)
    opponents_list(team_id).max_by do |opponent_id, results|
      find_percent(results[:wins], results[:games])
    end.first
  end

  def winningest_coach(game_team_ids)
    game_teams_from_ids = game_teams_from_ids(game_team_ids)
    coach_wins(game_teams_from_ids).max_by do |coach_name, coach_data|
      coach_data[:total_wins].fdiv(coach_data[:total_games])
    end.first
  end

  def worst_coach(game_team_ids)
    game_teams_from_ids = game_teams_from_ids(game_team_ids)
    coach_wins(game_teams_from_ids).min_by do |coach_name, coach_data|
      coach_data[:total_wins].fdiv(coach_data[:total_games])
    end.first
  end

  def game_teams_from_ids(game_team_ids)
    @game_teams.find_all do |game_team|
      game_team_ids.include?(game_team.game_id)
    end
  end

  def add_coach_data(coach_wins, game_team)
    coach_wins[game_team.head_coach][:total_wins] += 1 if game_team.result == "WIN"
    coach_wins[game_team.head_coach][:total_games] += 1
  end

  def coach_wins(game_teams_from_ids)
    coach_wins = Hash.new {|h, k| h[k] = {total_games: 0, total_wins: 0}}
    game_teams_from_ids.each do |game_team|
      add_coach_data(coach_wins, game_team)
    end
    coach_wins
  end

  def most_accurate_team(game_team_ids)
    game_teams_from_ids = game_teams_from_ids(game_team_ids)
    accuracy(game_teams_from_ids).min_by do |team_id, goals_data|
      goals_data[:total_shots].fdiv(goals_data[:total_goals])
    end.first
  end

  def least_accurate_team(game_team_ids)
    game_teams_from_ids = game_teams_from_ids(game_team_ids)
    accuracy(game_teams_from_ids).max_by do |team_id, goals_data|
      goals_data[:total_shots].fdiv(goals_data[:total_goals])
    end.first
  end

  def accuracy(game_teams_from_ids)
    accuracy = Hash.new {|h, k| h[k] = {total_goals: 0, total_shots: 0}}
    game_teams_from_ids.each do |game_team|
      add_goals_data(accuracy, game_team)
    end
    accuracy
  end

  def add_goals_data(accuracy, game_team)
    accuracy[game_team.team_id][:total_goals] += game_team.goals.to_i
    accuracy[game_team.team_id][:total_shots] += game_team.shots.to_i
  end

  def most_tackles(game_team_ids)
    game_teams_from_ids = game_teams_from_ids(game_team_ids)
    tackles_by_team(game_teams_from_ids).max_by do |team_id, tackles|
      tackles
    end.first
  end

  def fewest_tackles(game_team_ids)
    game_teams_from_ids = game_teams_from_ids(game_team_ids)
    tackles_by_team(game_teams_from_ids).min_by do |team_id, tackles|
      tackles
    end.first
  end

  def add_tackle_data(tackles, game_team)
    tackles[game_team.team_id] += game_team.tackles.to_i
  end

  def tackles_by_team(game_teams)
    tackles_by_team = Hash.new(0)
    game_teams.each do |game_team|
      add_tackle_data(tackles_by_team, game_team)
    end
    tackles_by_team
  end
end
