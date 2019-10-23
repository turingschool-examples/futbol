require 'csv'
require_relative 'game'

class GameCollection
  attr_reader :games

  def initialize(csv_path)
    @games = create_games(csv_path)
  end

  def create_games(csv_path)
    csv = CSV.read("#{csv_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end

  def total_games
    @games.length
  end
end
