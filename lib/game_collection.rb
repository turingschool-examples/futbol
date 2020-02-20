require 'csv'
require_relative 'game'

class GameCollection
  attr_reader :games_list

  def initialize(file_path)
    @games_list = create_games(file_path)
    require "pry"; binding.pry
  end

  def create_games(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end

  def get_all_seasons
    @games_list.find_all { |game| game.season}.uniq
  end
end
