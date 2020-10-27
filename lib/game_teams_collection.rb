require_relative './game_team'
require 'CSV'

class GameTeamsCollection
  attr_reader :teams, :game_teams
  def initialize(teams_path, game_teams_path)
    @teams = create_teams(teams_path)
    @game_teams = create_game_teams(game_teams_path)
  end

  def create_teams(teams_path)
    csv = CSV.read(teams_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      Team.new(row)
    end
  end

  def create_game_teams(game_teams_path)
    csv = CSV.read(game_teams_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      GameTeam.new(row)
    end
  end

  def games_by_team
    total_games = Hash.new(0)
    game_teams.each do |game_team|
      total_games[game_team.team_id] += 1
    end
    total_games
  end

  def average_goals_by_team
    average = Hash.new(0)
    game_teams.each do |game_team|
      average[game_team.team_id] += game_team.goals
    end
    games_by_team.merge(average) do |key, games, goals|
      goals.to_f / games
    end
  end

  def best_offense
    goals = average_goals_by_team.max_by do |goals|
      goals[-1]
    end
    @teams.select do |team|
      if team.team_id == goals[0]
        return team.teamname
      end
    end
  end

  def worst_offense
    goals = average_goals_by_team.min_by do |goals|
      goals
    end
    @teams.select do |team|
      if team.team_id == goals[0]
        return team.teamname
      end
    end
  end

  def highest_scoring_visitor

  end
end
