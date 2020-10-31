require "csv"
require "./lib/game"

class GameCollection
  attr_reader :game_path, :stat_tracker

  def initialize(game_path, stat_tracker)
    @game_path    = game_path
    @stat_tracker = stat_tracker
    @games        = []
    create_games(game_path)
  end

  def create_games(game_path)
    data = CSV.parse(File.read(game_path), headers: true)
    @games = data.map {|data| Game.new(data, self)}
  end

  def scores_by_game
    @games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.sort
  end

  def highest_total_score
    scores_by_game.last
  end

  def lowest_total_score
    scores_by_game.first
  end

  def count_of_games_by_season
    games_per_season = {}
    @games.each do |game|
      (games_per_season[game.season] += 1 if games_per_season[game.season]) ||
      (games_per_season[game.season] = 1)
    end
    games_per_season
  end

  def total_games
    @games.count
  end

  def average_goals_per_game
    (scores_by_game.sum / total_games.to_f).round(2)
  end

  def sum_of_scores_by_season
    scores_by_season = {}
    @games.each do |game|
      (scores_by_season[game.season] += game.away_goals.to_i + game.home_goals.to_i if scores_by_season[game.season]) ||
      (scores_by_season[game.season] = game.away_goals.to_i + game.home_goals.to_i)
    end
    scores_by_season
  end

  def season_id
    @games.map do |game|
      game.season
    end.uniq
  end

  def average_goals_by_season
    goals_per_season = {}
    season_id.each do |season|
      goals_per_season[season] = (sum_of_scores_by_season[season] /
                                count_of_games_by_season[season].to_f).round(2)
    end
    goals_per_season
  end

  def game_ids_per_season
    seasons_and_games = {}
    @games.each do |game|
      (seasons_and_games[game.season] << game.game_id if seasons_and_games[game.season]) ||
      (seasons_and_games[game.season] = [game.game_id])
    end
    seasons_and_games
  end

end
