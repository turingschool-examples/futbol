require 'csv'
require './lib/stat_tracker'
require './lib/game'

class GamesManager

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @games = []
    create_games(path)
  end

  def create_games(games_table)
    @games = games_table.map do |data|
      Game.new(data, self)
    end
  end

end
