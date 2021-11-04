require 'CSV'
require 'pry'

require_relative './games'

class GameManager
  attr_reader :game_objects, :game_path

  def initialize(game_path)
    @game_path = './data/games.csv'
    # @stat_tracker = stat_tracker
    @game_objects = (
      objects = []
      CSV.foreach(game_path, headers: true, header_converters: :symbol) do |row|
        objects << Games.new(row)
      end
      objects)
  end

  #   def create_game_manager
  #     x = CSV.read(game_path, headers: true, header_converters: :symbol) do |row|
  #     x.map do |row|
  #       Games.new(row)
  #       end
  #     end
  #   end
  # # binding.pry

  def highest_total_score
    @game_objects.map do |object|
      object.venue
    end.uniq
  end
end
