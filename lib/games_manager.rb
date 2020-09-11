require 'csv'
require_relative './stat_tracker'
require_relative './game'

class GamesManager

  attr_reader :stat_tracker, :games

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
