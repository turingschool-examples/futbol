require 'csv'
require_relative 'game'
require_relative 'csvloadable'

class GamesCollection
  include CsvLoadable

  attr_reader :games

  def initialize(games_path)
    @games = create_games(games_path)
  end

  def create_games(games_path)
    create_instances(games_path, Game)
  end

  def average_goals_per_game
    goals_per_game = @games.map {|game| game.away_goals + game.home_goals}
    all_goals = goals_per_game.sum
    number_of_games = goals_per_game.length
    average_goals_per_game = all_goals / number_of_games.to_f
    average_goals_per_game.round(2)
  end

  def average_goals_by_season
    season_to_game = games.reduce({}) do |acc, game|
      if acc[game.season] == nil
        acc[game.season] = []
        acc[game.season] << game
      else
        acc[game.season] << game
      end
      acc
    end

    avg_by_season = {}
    season_to_game.each do |season, games|
      avg_by_season[season] = ((games.map {|game| game.away_goals +
        game.home_goals}).sum / (games.map {|game| game.away_goals +
          game.home_goals}).length.to_f).round(2)
    end
    avg_by_season
  end
end
