require 'csv'
require_relative 'game'

class LeagueStatistics
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def count_of_teams
    @teams.size
  end

  def best_offense
    team_name(team_avg_goals.max_by { |team_id, avg_goals| avg_goals }[0])
  end

  def worst_offense
    team_name(team_avg_goals.min_by { |team_id, avg_goals| avg_goals }[0])
  end
  
  def team_avg_goals
    total_goals_by_team = Hash.new(0)
    total_games_by_team = Hash.new(0)

    @game_teams.each do |game_team|
      team_id = game_team.team_id
      total_goals_by_team[team_id] += game_team.goals
      total_games_by_team[team_id] += 1
    end

    total_goals_by_team.transform_values do |total_goals|
      total_goals.to_f / total_games_by_team[team_id]
    end
  end

  def team_name(team_id)
    @teams[team_id]&.team_name
  end


end
