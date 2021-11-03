require 'CSV'
require 'pry'

class GameManager
  attr_reader :game_objects, :game_path
  def initialize(game_path)
    @game_path = './data/games.csv'
    # @stat_tracker = stat_tracker
    @game_objects = []
  end

  def create_game_manager
    objects = []
    x = CSV.foreach(game_path, headers: true, header_converters: :symbol) do |row|
      binding.pry
      objects << GameManager.new(row)
    end
  end
end
