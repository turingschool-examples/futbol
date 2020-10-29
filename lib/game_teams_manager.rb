require 'csv'

class GameTeamsManager
  attr_reader :game_teams,
              :parent
  def initialize(file_location, parent)
    all(file_location)
    @parent = parent
  end

  def all(file_location)
    game_teams_data = CSV.read(file_location, headers: true, header_converters: :symbol)
    @game_teams = game_teams_data.map do |game_team_data|
      GameTeam.new(game_team_data, self)
    end
  end

  def goals_by_team
    id_by_goals = Hash.new {|hash, key| hash[key] = 0}
    @game_teams.each do |game_team|
      id_by_goals[game_team.team_id] += game_team.goals
    end
    id_by_goals
  end

  def game_count(team_id)
    @game_teams.count do |game|
      game.team_id == team_id
    end
  end

  def best_offense
    hash = {}
    goals_by_team.map do |team_id, goals|
      hash[team_id] = (goals.to_f / game_count(team_id)).round(2)
    end
    hash.max_by do |team_id, average_goals|
      average_goals
    end.first
  end
end
