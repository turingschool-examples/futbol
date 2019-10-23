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

  def highest_total_score
    game_sums = @total_games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.max_by { |sum| sum }
  end

  def percentage_ties
    ties_count = @total_games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties_count / @total_games.count.to_f).round(2)
  end

  def count_of_games_by_season
    count_games_by_season_list = {}
    @total_games.each do |game|
      count_games_by_season_list[game.season] = 0
    end
    @total_games.each do |game|
      count_games_by_season_list[game.season] += 1
    end
    return count_games_by_season_list
  end
end
