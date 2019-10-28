require 'CSV'
require_relative './game_team'

class GameTeamCollection
  attr_reader :game_teams, :game_teams_by_team_id

  def self.load_data(path)
    game_teams = {}
    game_teams_by_team_id = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      game_team = GameTeam.new(row)
      if game_teams.keys.include?(row[:game_id])
        game_teams[row[:game_id]] << game_team
      else
        game_teams[row[:game_id]] = []
        game_teams[row[:game_id]] << game_team
      end

      if game_teams_by_team_id.keys.include?(row[:team_id])
        game_teams_by_team_id[row[:team_id]] << game_team
      else
        game_teams_by_team_id[row[:team_id]] = []
        game_teams_by_team_id[row[:team_id]] << game_team
      end
    end

    GameTeamCollection.new(game_teams, game_teams_by_team_id)
  end

  def initialize(game_teams, by_team)
    @game_teams = game_teams
    @game_teams_by_team_id = by_team
  end

  def most_goals
    @game_teams_by_team_id.max_by do |team_id, game_array|
      total = game_array.sum do |game|
        game.goals
      end
      (total.to_f / game_array.length).round(2)
    end[0]
  end

  def fewest_goals
    @game_teams_by_team_id.min_by do |team_id, game_array|
      total = game_array.sum do |game|
        game.goals
      end
      (total.to_f / game_array.length).round(2)
    end[0]
  end
end
