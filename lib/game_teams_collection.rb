<<<<<<< HEAD

=======
>>>>>>> master
require_relative './game_team'
require 'csv'

class GameTeamCollection
  attr_reader :game_team_collection

  def initialize(game_team_collection)
    @game_team_collection = game_team_collection
  end

  def self.all(game_team_collection)
    all_game_teams = []
    CSV.read(game_team_collection, headers: true).each do |game_team|
      game_team_hash = {
        game_id: game_team_collection["game_id"].to_i,
        team_id: game_team_collection["team_id"].to_i,
        hoa: game_team_collection["HoA"],
        result: game_team_collection["result"],
        head_coach: game_team_collection["head_coach"],
        goals: game_team_collection["goals"].to_i,
        shots: game_team_collection["shots"].to_i,
        tackles: game_team_collection["tackles"],
      }
      all_game_teams << GameTeams.new(game_team_hash)
    end
    all_game_teams
  end
end
