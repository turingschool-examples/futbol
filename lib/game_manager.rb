require_relative 'game'
require 'csv'

class GameManager
  attr_reader :games
  def initialize(locations, stat_tracker)
    @stat_tracker = stat_tracker
    @games = generate_games(locations[:games])
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
end