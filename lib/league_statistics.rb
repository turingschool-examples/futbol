require 'csv'
require './lib/game_team'
require './lib/team'

class LeagueStatistics
  attr_reader :teams,
              :game_teams

  def initialize(teams, game_teams)
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(game_teams_filepath,teams_filepath)
    game_teams = []

    CSV.foreach(game_teams_filepath, headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end

    teams = []

    CSV.foreach(teams_filepath, headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)
    end

    new(teams, game_teams)
  end

  def count_of_teams
    @teams.size
  end

  def best_offense
    teams_goals = {}
    @game_teams.each do |game_team|
      team_id = game_team.team_id
      goals = game_team.goals.to_f
      teams_goals[team_id] ||= []
      teams_goals[team_id] << goals
    end
  
    average_goals = teams_goals.transform_values { |goals| goals.sum / goals.size.to_f }
    best_team_id = average_goals.key(average_goals.values.max)
  
    best_team = @teams.find { |team| team.team_id == best_team_id }
    best_team.teamname
  end

  def worst_offense
    teams_goals = {}

    @game_teams.each do |game_team|
      team_id = game_team.team_id
      goals = game_team.goals.to_f
      teams_goals[team_id] ||= []
      teams_goals[team_id] << goals
    end

    average_goals = teams_goals.transform_values { |goals| goals.sum / goals.size.to_f }
    worst_team_id = average_goals.key(average_goals.values.min)

    worst_team = @teams.find { |team| team.team_id == worst_team_id }
    worst_team.teamname
  end

  def highest_scoring_vistor
  end

  def lowest_scoring_visitor
  end
end
