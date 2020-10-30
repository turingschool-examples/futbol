require "csv"
require "./lib/game"

class GameCollection
  attr_reader :game_path, :stat_tracker

  def initialize(game_path, stat_tracker)
    @game_path    = game_path
    @stat_tracker = stat_tracker
    @games        = []
    create_games(game_path)
  end

  def create_games(game_path)
    data = CSV.parse(File.read(game_path), headers: true)
    @games = data.map {|data| Game.new(data, self)}
  end
end
