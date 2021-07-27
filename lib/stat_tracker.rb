require 'csv'
require './lib/game'
require './lib/team'
require './lib/game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(stats)
    @games = stats[:games]
    @teams = stats[:teams]
    @game_teams = stats[:game_teams]
  end

  def self.from_csv(locations)
    stats = {}
    stats[:games] = create_game_csv(locations)
    stats[:teams] = create_teams_csv(locations)
    stats[:game_teams] = create_game_teams_csv(locations)

    StatTracker.new(stats)

  end

  def self.create_game_csv(locations)
    games = []
    game_csv = CSV.foreach(locations[:games], headers: true) do |row|
      game = Game.new(row)
      games << game
    end
    games
  end

  def self.create_teams_csv(locations)
    teams = []
    team_csv = CSV.foreach(locations[:teams], headers: true) do |row|
      team = Team.new(row)
      teams << team
    end
    teams
  end

  def self.create_game_teams_csv(locations)
    game_teams = []
    game_team_csv = CSV.foreach(locations[:game_teams], headers: true) do |row|
      game_team = GameTeam.new(row)
      game_teams << game_team
    end
    game_teams
  end
# GAME STATISTICS
  def highest_total_score
    game_sums = @games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.max
  end

  def lowest_total_score
    game_sums = @games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.min
  end

# LEAGUE STATISTICS
  def count_of_teams
    @teams.count 
  end

  def games_by_team_id
    teams = {}
    @game_teams.each do |team|
      if teams[team.team_id].nil?
        teams[team.team_id] = [team]
      elsif !teams[team.team_id].include?(team)
        teams[team.team_id] << team
      end
    end
    teams
  end

  def goals_per_team
    team_goals = {}
    @game_teams.each do |team|
      if team_goals[team.team_id].nil?
        team_goals[team.team_id] = [team.goals]
      else
        team_goals[team.team_id] << team.goals
      end
    end
    team_goals 
  end

  def team_name_by_team_id(team_id)
    team = @teams.find do |team|
      team_id == team.team_id
    end
    team.team_name
  end

  def best_offense
    team_id = goals_per_team.max_by do |team, goals|
      goals.sum / goals.count.to_f
    end
    team_name_by_team_id(team_id.first)
  end

  def worst_offense
    team_id = goals_per_team.min_by do |team, goals|
      goals.sum / goals.count.to_f
    end
    team_name_by_team_id(team_id.first)
  end
end
