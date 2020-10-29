require 'CSV'
require './lib/game'
class GamesRepo
  attr_reader :parent, :games

  def initialize(path, parent)
    @parent = parent
    @games = create_games(path)
  end

  def create_games(path)
    rows = CSV.readlines('./data/games.csv', headers: :true , header_converters: :symbol)

    rows.map do |row|
      Game.new(row, self)
    end
  end

  def highest_total_goals
    @games.max_by do |game|
      game.total_goals
    end.total_goals
  end

  def lowest_total_goals
    @games.min_by do |game|
      game.total_goals
    end.total_goals
  end

  def count_of_games_in_season(season)
    @games.select do |game|
      game.season == season
    end.count
  end

  def count_of_games_by_season
    seasons = @games.map do |game|
      game.season
    end.uniq
    hash = {}
    seasons.each do |season|
      hash[season]= count_of_games_in_season(season)
    end
    hash
  end

  def average_goals_per_game
    average_goals = @games.sum do |game|
      game.total_goals
    end.to_f / @games.count
    average_goals.round(2)
  end

  def average_goals_by_season
    hash = count_of_games_by_season
    hash.each_pair do |season, num_games|
      season_games = @games.select do |game|
        game.season == season
      end
      hash[season] = season_games.sum do |game|
        game.total_goals
      end.to_f / num_games
      hash[season] = hash[season].round(2)
    end
    hash
  end
end
