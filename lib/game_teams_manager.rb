require 'csv'
require_relative './mathable'
require_relative './supportable'

class GameTeamsManager
  include Mathable
  include Supportable

  attr_reader :game_teams

  def initialize(file_location)
    all(file_location)
  end

  def all(file_location)
    game_teams_data = CSV.read(file_location, headers: true, header_converters: :symbol)
    @game_teams = game_teams_data.map do |game_team_data|
      GameTeam.new(game_team_data)
    end
  end

  def find_game_teams(home_or_away = nil)
    @game_teams.select do |game_team|
      game_team.check(home_or_away)
    end
  end

  def total_goals_by_team(home_or_away = nil)
    team_goals = counter_sub_hash
    find_game_teams(home_or_away).each do |game|
      team_goals[game.team_id][:game_count] += 1
      team_goals[game.team_id][:goals] += game.goals
    end
    team_goals
  end

  def avg_goals_by_team(home_or_away = nil)
    avg_goals = {}
    total_goals_by_team(home_or_away).each do |team_id, stats|
      avg_goals[team_id] = percentage(stats[:goals], stats[:game_count], 4)
    end
    avg_goals
  end

  def best_offense
    avg_goals_by_team.max_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def worst_offense
    avg_goals_by_team.min_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def highest_scoring_visitor
    avg_goals_by_team('away').max_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def highest_scoring_home_team
    avg_goals_by_team('home').max_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def lowest_scoring_visitor
    avg_goals_by_team('away').min_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def lowest_scoring_home_team
    avg_goals_by_team('home').min_by do |team_id, average_goals|
      average_goals
    end.first
  end

  def games_by_season(game_ids)
    @game_teams.select do |game_team|
      game_ids.include?(game_team.game_id)
    end
  end

  def coach_stats(game_ids)
    stats = counter_sub_hash
    games_by_season(game_ids).each do |game|
      stats[game.head_coach][:game_count] += 1
      stats[game.head_coach][:num_wins]
      stats[game.head_coach][:num_wins] += 1 if game.result == "WIN"
    end
    stats
  end

  def winningest_coach(game_ids)
    coach_stats(game_ids).max_by do |coach_name, stats|
      percentage(stats[:num_wins], stats[:game_count], 4)
    end.first
  end

  def worst_coach(game_ids)
    coach_stats(game_ids).min_by do |coach_name, stats|
      percentage(stats[:num_wins], stats[:game_count], 4)
    end.first
  end

  def team_goal_ratio(game_ids)
    team_shots = counter_sub_hash
    games_by_season(game_ids).each do |game_team|
      team_shots[game_team.team_id][:goals] += game_team.goals
      team_shots[game_team.team_id][:shots] += game_team.shots
    end
    team_shots
  end

  def most_accurate_team(game_ids)
    team_goal_ratio(game_ids).max_by do |team_id, ratio_hash|
      percentage(ratio_hash[:goals], ratio_hash[:shots], 4)
    end.first
  end

  def least_accurate_team(game_ids)
    team_goal_ratio(game_ids).min_by do |team_id, ratio_hash|
      percentage(ratio_hash[:goals], ratio_hash[:shots], 4)
    end.first
  end

  def total_tackles_by_team(game_ids)
    team_tackles = counter_hash
    games_by_season(game_ids).each do |game_team|
      team_tackles[game_team.team_id] += game_team.tackles
    end
    team_tackles
  end

  def most_tackles(game_ids)
    total_tackles_by_team(game_ids).max_by do |team_id, tackles|
      tackles
    end.first
  end

  def fewest_tackles(game_ids)
    total_tackles_by_team(game_ids).min_by do |team_id, tackles|
      tackles
    end.first
  end
end
