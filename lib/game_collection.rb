require 'csv'
require './lib/game'
require './lib/stat_tracker'

class GameCollection
  attr_reader :game_instances

  def initialize(game_path)
    @game_path = game_path
    all_games

  end

  def all_games
    @game_instances = []
    csv = CSV.read("#{@game_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      @game_instances <<  Game.new(row)
    end
    @game_instances
  end

  def average_goals_per_game

  end
end
