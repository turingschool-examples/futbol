require 'csv'

class GamesStats

  def initialize
    @games = CSV.open('./data/games.csv', headers: true, header_converters: :symbol).map { |row| Game.new(row) }
  end

  def highest_total_score
    high_score = @games.max_by{ |game| game.total_score }
    high_score.total_score
  end

  def lowest_total_score
    low_score = @games.min_by{ |game| game.total_score }
    low_score.total_score
  end
end