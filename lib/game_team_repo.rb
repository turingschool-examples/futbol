require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class GameTeamRepo
  attr_reader :game_teams

  def initialize(locations)
    @game_teams = GameTeam.read_file(locations[:game_teams])
  end

  def average_goals_team
    total_goals_by_team = Hash.new(0)
    @game_teams.each do |game_team|
      total_goals_by_team[game_team.team_id] = [game_team.goals.to_i]
    end
    total_goals_by_team 

    avg_goals_by_team = Hash.new(0)
    total_goals_by_team.each do |id, total_goals|
      total_goals.each do |total_goal|
       avg_goals_by_team[id] = (total_goal / @game_teams.find_all { |game| game.team_id == id }.length).to_f.round(2)
      end
    end
    # require 'pry'; binding.pry
    avg_goals_by_team
  end

  def highest_avg_goals_by_team
    average_goals_team.max_by do |game, goals|
      goals
    end.first
  end

  def lowest_avg_goals_by_team
    average_goals_team.min_by do |game, goals|
      goals
    end.first
  end
end