require_relative './game_team'
require 'CSV'

class GameTeamsCollection
  attr_reader :game_teams
  def initialize(file_path)
    @game_teams = []
    create_game_teams(file_path)
  end

  def create_game_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @game_teams << GameTeam.new(row)
    end
  end

  def goals_by_team
    total_goals = Hash.new(0)
    game_teams.each do |game_team|
      total_goals[game_team.team_id] += game_team.goals
    end
    total_goals
  end

  def best_offense
    goals_by_team.max_by do |goals|
      goals[-1]
    end
  end
end
