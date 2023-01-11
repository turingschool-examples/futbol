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
    # require 'pry'; binding.pry

    avg_goals_by_team = Hash.new(0)
    total_goals_by_team.each do |id, total_goals|
      total_goals.each do |total_goal|
       avg_goals_by_team = (total_goal / @game_teams.find_all { |game| game.team_id == id }.length).round(2)
        # require 'pry'; binding.pry
      end
    end
    avg_goals_by_team
      
    # require 'pry'; binding.pry
  end
end