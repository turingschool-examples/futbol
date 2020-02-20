require 'csv'
require_relative 'game'

class GameCollection
  attr_reader :games_list

  def initialize(file_path)
    @games_list = create_games(file_path)
  end

  def create_games(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end
end
