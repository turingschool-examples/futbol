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

  def average_goals(array)
    total_goals = array.reduce(0) do |sum, game|
      sum += game.total_score
      sum
    end
    (total_goals.to_f / array.length).round(2)
  end

  def average_goals_per_game
    average_goals(@games)
  end

  def average_goals_by_season
    season_hash = game_lists_by_season
    season_hash.each do |key, value|
      season_hash[key] = average_goals(value)
    end
  end

  def game_lists_by_season
    @games.reduce({}) do |hash, game|
      hash[game.season] << game if hash[game.season]
      hash[game.season] = [game] if hash[game.season].nil?
      hash
    end
  end

  def games_by_season
    season_games = game_lists_by_season
    season_games.each do |key, value|
      season_games[key] = value.length
    end
    season_games
  end

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
