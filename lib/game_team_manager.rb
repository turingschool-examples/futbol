require_relative 'game_teams'
require 'csv'

class GameTeamManager
  attr_reader :game_teams
  def initialize(location, stat_tracker) # I need a test
    @stat_tracker = stat_tracker
    @game_teams = generate_game_teams(location)
  end

  def generate_game_teams(location) # I need a test
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << GameTeams.new(row.to_hash)
    end
    array
  end

  def game_ids_by_team(id)
    game_teams.select do |game_team|
      game_team.team_id == id
    end.map(&:game_id)
  end

  def game_team_info(game_id)
    game_teams.select do |game_team|
      game_team.game_id == game_id
    end.reduce({}) do |collector, game|
      collector[game.team_id] = game.game_team_info
      collector
    end
  end
end
