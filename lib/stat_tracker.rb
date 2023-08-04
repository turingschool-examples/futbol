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

  def highest_scoring_home_team
    total_goals = @game_teams.each_with_object({}) do |game, hash|
      hash[game.team_id] = hash[game.team_id] || [0, 0]
      if game.hoa == "home"
        hash[game.team_id] = [game.goals + hash[game.team_id][0], hash[game.team_id][1] + 1]
      end
    end

    avg_goals = total_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    highest_avg_goals = avg_goals.values.max
    
    highest_team_id = avg_goals.key(highest_avg_goals)

    @teams.each do |team| 
      return team.team_name if team.team_id == highest_team_id
    end
  end

  def lowest_scoring_home_team
    total_goals = @game_teams.each_with_object({}) do |game, hash|
      hash[game.team_id] = hash[game.team_id] || [0, 0]
      if game.hoa == "home"
        hash[game.team_id] = [game.goals + hash[game.team_id][0], hash[game.team_id][1] + 1]
      end
    end

    avg_goals = total_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    lowest_avg_goals = avg_goals.values.min

    lowest_team_id = avg_goals.key(lowest_avg_goals)

    @teams.each do |team| 
      return team.team_name if team.team_id == lowest_team_id
    end
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end
end