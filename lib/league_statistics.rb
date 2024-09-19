require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class LeagueStatistics
  attr_reader :games,
              :teams,
              :game_teams,
              :stat_tracker

  def initialize(games, teams, game_teams, stat_tracker)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @stat_tracker = stat_tracker
  end

  def count_of_teams
    @teams.size
  end

  def best_offense
    team_id = team_avg_goals.max_by { |team_id, avg_goals| avg_goals}[0]
    @stat_tracker.team_name(team_id)
  end

  def worst_offense
     team_id = team_avg_goals.min_by { |team_id, avg_goals| avg_goals}[0]
    @stat_tracker.team_name(team_id)
  end
  
  def team_avg_goals
    total_goals_by_team = Hash.new(0)
    total_games_by_team = Hash.new(0)

    @game_teams.each do |game_team|
      team_id = game_team.team_id
      total_goals_by_team[team_id] += game_team.goals.to_i
      total_games_by_team[team_id] += 1
    end

    total_goals_by_team.transform_values do |total_goals|
      team_id = total_games_by_team.key(total_goals)
      total_goals.to_f / total_games_by_team[team_id]
    end
  end

  def team_name(team_id)
    team = @team.find { |team| team.team_id == team_id}
    team.team_name
  end
end
