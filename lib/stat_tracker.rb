require 'csv'
require_relative 'team'
require_relative 'game'
require_relative "game_team"
require_relative 'game_statable'

class StatTracker
include GameStatable

  attr_reader :games, :teams, :game_teams

  def initialize(files)
    @games = (CSV.foreach files[:games], headers: true, header_converters: :symbol).map do |row|
      Game.new(row)
    end
    @teams = (CSV.foreach files[:teams], headers: true, header_converters: :symbol).map do |row|
      Team.new(row)
    end
    @game_teams = (CSV.foreach files[:game_teams], headers: true, header_converters: :symbol).map do |row|
      GameTeam.new(row)
    end
  end

  def highest_scoring_visitor 
    away_games_by_team_id = @games.each_with_object(Hash.new(0.0)) do |game, hash|
      hash[game.away_team_id] += 1
    end

    away_goals_by_team_id = @games.each_with_object(Hash.new(0.0)) do |game, hash|
      hash[game.away_team_id] += game.away_goals
    end
    
    average_away_goals_by_team_id = Hash.new(0.0)
    away_goals_by_team_id.each do |key, value|
      average_away_goals_by_team_id[key] = (value/ away_games_by_team_id[key]).round(2)
    end
    average_away_goals_by_team_id
    highest_average_scoring_team_id = average_away_goals_by_team_id.max_by {|k, v| v}.first
    
    highest_scoring_team = @teams.find do |team|
      team.team_name if team.team_id == highest_average_scoring_team_id
    end
    team = highest_scoring_team.team_name
    require 'pry';binding.pry
  end


  def self.from_csv(files)
    StatTracker.new(files)
  end
end