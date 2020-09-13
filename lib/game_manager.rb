require_relative 'game'
require 'csv'

class GameManager
  attr_reader :games
  def initialize(location, stat_tracker)
    @stat_tracker = stat_tracker
    @games = generate_games(location)
  end

  def generate_games(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << Game.new(row.to_hash)
    end
    array
  end

  def group_by_season
    @games.group_by do |game|
      game.season
    end.uniq
  end

  def game_info(game_id)
    games.find do |game|
      game.game_id == game_id
    end.game_info
  end
end
