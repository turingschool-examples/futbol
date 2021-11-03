require 'csv'
require './lib/stat_tracker'

class Game
  def initialize(game_path)
    @game_id    = @game_path[:game_id]
    @season     = @game_path[:season]
    @game_path  = game_path
  end

  def to_array
    rows = []

    CSV.foreach(@game_path, headers: true, header_converters: :symbol) do |row|
      rows << row.to_h
    end
    rows
    require "pry"; binding.pry
  end
