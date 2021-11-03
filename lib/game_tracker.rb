require 'csv'
require './lib/stat_tracker'

class GameTracker
  def initialize(game_path)
    @game_path = game_path
  end

  def to_array
    rows = []

    CSV.foreach(@game_path, headers: true, header_converters: :symbol) do |row|
      rows << row.to_h
    end
    rows
    require "pry"; binding.pry
  end

  # def location
  #   @game_path = CSV.read(@game_path, headers: true, header_converters: :symbol)
  # end
end
