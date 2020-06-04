require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './game_collection'
require_relative './team_collection'
require_relative './game_teams_collection'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)
    @games = GameCollection.all(info[:games])
    @teams = TeamCollection.all(info[:teams])
    @game_teams = GameTeamsCollection.all(info[:game_teams])
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  def count_of_teams
    teams.count
  end

  def best_offense
    teams_with_goals = Hash.new
    game_teams.each do |game_by_team|
      teams_with_goals[game_by_team.team_id] = game_by_team.goals if teams_with_goals[game_by_team.team_id].nil?
      teams_with_goals[game_by_team.team_id] += game_by_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2
    average_goals = teams_with_goals.each_value do |score|
      score/game_number
    end

    best_team = average_goals.each_pair.reduce do |result, key_value|
      if key_value[1] > result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == best_team[0]
    end.name
  end

  def worst_offense
    teams_with_goals = Hash.new
    game_teams.each do |game_by_team|
      teams_with_goals[game_by_team.team_id] = game_by_team.goals if teams_with_goals[game_by_team.team_id].nil?
      teams_with_goals[game_by_team.team_id] += game_by_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2
    average_goals = teams_with_goals.each_value do |score|
      score/game_number
    end

    worst_team = average_goals.each_pair.reduce do |result, key_value|
      if key_value[1] < result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == worst_team[0]
    end.name
  end

  def highest_scoring_visitor
    away_teams = game_teams.find_all do |game_by_team|
      game_by_team.hoa == "away"
    end
    # away_teams is an array of GameTeam objects
    teams_with_goals = {}
    away_teams.each do |game_team|
      teams_with_goals[game_team.team_id] = game_team.goals if teams_with_goals[game_team.team_id].nil?
      teams_with_goals[game_team.team_id] += game_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2

    teams_with_goals.update(teams_with_goals) do |team, goals|
      goals.to_f / game_number
    end

    highest_visitor = teams_with_goals.each_pair.reduce do |result, key_value|
      if key_value[1] > result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == highest_visitor[0]
    end.name
  end

  def lowest_scoring_visitor
    away_teams = game_teams.find_all do |game_by_team|
      game_by_team.hoa == "away"
    end
    # away_teams is an array of GameTeam objects
    teams_with_goals = {}
    away_teams.each do |game_team|
      teams_with_goals[game_team.team_id] = game_team.goals if teams_with_goals[game_team.team_id].nil?
      teams_with_goals[game_team.team_id] += game_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2

    teams_with_goals.update(teams_with_goals) do |team, goals|
      goals.to_f / game_number
    end

    lowest_visitor = teams_with_goals.each_pair.reduce do |result, key_value|
      if key_value[1] < result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == lowest_visitor[0]
    end.name
  end
end

  # highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
  # highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
  # lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
  # lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String
