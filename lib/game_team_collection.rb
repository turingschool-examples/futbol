require 'CSV'
require_relative './game_team'

class GameTeamCollection
  attr_reader :game_teams

  def self.load_data(path)
    game_teams = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      if game_teams.keys.include?(row[:game_id])
          game_teams[row[:game_id]] << GameTeam.new(row)
      else
          game_teams[row[:game_id]] = []
          game_teams[row[:game_id]] << GameTeam.new(row)
      end
    end

    GameTeamCollection.new(game_teams)
  end

  def initialize(game_teams)
    @game_teams = game_teams
  end
end
