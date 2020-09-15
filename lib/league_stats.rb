require './lib/stats'
require_relative 'hashable'
require_relative 'groupable'
require_relative 'calculatable'

class LeagueStats < Stats
  include Hashable
  include Groupable
  include Calculatable
  attr_reader :tracker

  def initialize(tracker)
    @tracker = tracker
    super(game_stats_data, game_teams_stats_data, teams_stats_data)
  end

  def count_of_teams
    @team_stats_data.count_of_teams
  end

  def best_offense_stats
    stats = team_id_and_average_goals.sort_by do |key, value|
      value
    end
    stats[-1][0]
  end

  def best_offense
    best_attack = @teams_stats_data.find do |team|
      team.teamname if best_offense_stats == team.team_id
    end
    best_attack.teamname
  end

  def worst_offense_stats
    stats = team_id_and_average_goals.sort_by do |key, value|
      value
    end
    stats[0][0]
  end

  def worst_offense
    worst_attack = @teams_stats_data.find do |team|
      team.teamname if worst_offense_stats == team.team_id
    end
    worst_attack.teamname
  end

  def team_highest_away_goals
    away_goals = team_id_and_average_away_goals.sort_by do |team, goals|
      goals
    end
    away_goals[-1][0]
  end

  def highest_scoring_visitor
    visitor = @teams_stats_data.find do |team|
      team.teamname if team_highest_away_goals == team.team_id
    end
    visitor.teamname
  end

  def team_lowest_away_goals
    away_goals = team_id_and_average_away_goals.sort_by do |team, goals|
      goals
    end
    away_goals[0][0]
  end

  def team_highest_home_goals
    home_goals = team_id_and_average_home_goals.sort_by do |team, goals|
      goals
    end
    home_goals[-1][0]
  end

  def highest_scoring_home_team
    home = @teams_stats_data.find do |team|
      team.teamname if team_highest_home_goals == team.team_id
    end
    home.teamname
  end

  def team_lowest_home_goals
    home_goals = team_id_and_average_home_goals.sort_by do |team, goals|
      goals
    end
    home_goals[0][0]
  end

  def lowest_scoring_visitor
    visitor = @teams_stats_data.find do |team|
      team.teamname if team_lowest_away_goals == team.team_id
    end
    visitor.teamname
  end

  def lowest_scoring_home_team
    home = @teams_stats_data.find do |team|
      team.teamname if team_lowest_home_goals == team.team_id
    end
    home.teamname
  end

  def count_of_ties
    double_ties = @game_teams_stats_data.find_all do |game_team|
      game_team.result == "TIE"
    end
    double_ties.count / 2
  end

  def all_visitor_wins
    @game_teams_stats_data.select do |game_team|
      game_team.hoa == "away" && game_team.result == "WIN"
    end
  end

  def all_home_wins
    @game_teams_stats_data.select do |game_team|
      game_team.hoa == "home" && game_team.result == "WIN"
    end
  end

  # def group_by_team_id
  #   @game_teams_stats_data.group_by do |team|
  #     team.team_id
  #   end
  # end
  #
  # def games_from_season(season)
  #   @game_teams_stats_data.find_all do |game_team|
  #     game_team.game_id.to_s.split('')[0..3].join.to_i == season.split('')[0..3].join.to_i
  #   end
  # end
  #
  # def all_team_games(team_id)
  #   @game_teams_stats_data.find_all do |game_team|
  #     game_team.team_id == team_id.to_i
  #   end
  # end
end
