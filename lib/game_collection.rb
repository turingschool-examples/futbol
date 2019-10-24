require 'csv'
require './lib/game.rb'

class GameCollection
  attr_reader :total_games

  def initialize(game_path)
    @total_games = create_games(game_path)
  end

# created class method in Game to find all_games
  def create_games(game_path)
    csv = CSV.read(game_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      Game.new(row)
    end
  end

  #method to sort by total goals
  #max_by { \game| game. away + game. home}
  #min_by ""
  # OR just sort game_sums and pull the first/last
  def highest_total_score
    game_sums = @total_games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.max_by { |sum| sum }
  end

  def lowest_total_score
    #game_sums has been used the same twice now
    game_sums = @total_games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.min_by { |sum| sum }
  end

  def biggest_blowout
    game_differences = @total_games.map do |game|
      (game.home_goals - game.away_goals).abs
    end
    game_differences.max_by { |difference| difference }
  end

  def percentage_home_wins
    home_wins = @total_games.find_all do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.length.to_f / @total_games.length * 100).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @total_games.find_all do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.length.to_f / @total_games.length * 100).round(2)
  end
end
