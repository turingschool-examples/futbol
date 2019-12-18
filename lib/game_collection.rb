require_relative "game"
require "csv"
require "pry"

class GameCollection
  attr_reader :games

  def initialize(file_path)
    @games = create_games(file_path)
  end

  def create_games(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map { |row| Game.new(row) }
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.to_f / @games.length).round(2)
  end

  def percentage_ties
    ties_count = @games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties_count.to_f / @games.length).round(2)

  def highest_total_score
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
end
