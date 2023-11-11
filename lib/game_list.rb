require 'CSV'
require_relative './game'

class GameList
  attr_reader :games, :stat_tracker

  def initialize(path, stat_tracker)
    @games = create_games(path)
    @stat_tracker = stat_tracker
  end

  def create_games(path)
      data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
      data.map do |datum|
        Game.new(datum, self)
      end
    end

  def highest_total_score
    @games.max_by do |game|
      game.total_score
    end.total_score
  end

  def lowest_total_score
    @games.min_by do |game|
      game.total_score
    end.total_score
  end
end
