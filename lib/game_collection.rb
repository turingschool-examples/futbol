require 'csv'
require './lib/game'

class GameCollection
  attr_reader :game_collection

  def initialize(game_collection)
    @game_collection = game_collection
  end

  def all
    all_games = []
    CSV.read(game_collection, headers: true).each do |game|
      game_hash = {id: game["game_id"],
        season: game["season"],
        type: game["type"],
        date_time: game["date_time"],
        away_team_id: game["away_team_id"],
        home_team_id: game["home_team_id"],
        away_goals: game["away_goals"],
        home_goals: game["home_goals"],
        venue: game["venue"]
      }
      all_games << Game.new(game_hash)
    end
    all_games
  end
end
