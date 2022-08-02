require 'csv'
require_relative './game_teams.rb'
require './helpable'

class GameTeamsStats
  include Helpable

  attr_reader :game_teams

  def initialize(game_teams)
    @game_teams = game_teams
  end

  def self.from_csv(location)
    game_teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    game_teams_as_objects = game_teams.map { |row| GameTeams.new(row) }
    GameTeamsStats.new(game_teams_as_objects)
  end

  def most_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      goals_by_game << game.goals.to_i if team_id == game.team_id
    end
    goals_by_game.max
  end

  def fewest_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      goals_by_game << game.goals.to_i if team_id == game.team_id
    end
    goals_by_game.min
  end


  def best_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }

    team_scores_average =
      team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #create an average out of the scores
      end
  end

  def worst_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }
    team_scores_average =
      team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #creat an average out of the scores
      end
  end


  #methods go here
end
