require_relative "game"
require "csv"

class GameCollection
  attr_reader :games

  def initialize(file_path)
    @games = create_games(file_path)
  end

  def create_games(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map { |row| Game.new(row) }
  end

  def highest_total_score
    # highest_score = 0
    # @games.each do |game|
    #   if game.total_score > highest_score
    #     highest_score = game.total_score
    #     end
    #   end
    #   highest_score
    highest_score = @games.max_by do |game|
      game.total_score
    end.total_score
      highest_score

  end

  def lowest_total_score
    lowest_score = @games.min_by do |game|
      game.total_score
    end.total_score
      lowest_score
  end

  def biggest_blowout
      games_difference = @games.max_by do |game|
        game.difference_between_score
    end.difference_between_score
    games_difference
  end
end
