require 'csv'
require_relative 'game'
require_relative 'stat_tracker'

class GameCollection
  attr_reader :game_instances

  def initialize(game_path)
    @game_path = game_path
    @game_instances = all_games
  end

  def all_games
    game_objects = []
    csv = CSV.read("#{@game_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      game_objects <<  Game.new(row)
    end
    game_objects
  end

  def average_goals_per_game
  require "pry"; binding.pry
  end
end
