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

  def highest_total_score
    highest_total = @games.max_by { |game| game.away_goals + game.home_goals}
    highest_total.away_goals + highest_total.home_goals
  end

  def lowest_total_score
    lowest_total = @games.min_by { |game| game.away_goals + game.home_goals }
    lowest_total.away_goals + lowest_total.home_goals
  end

  def biggest_blowout
    blowout = @games.max_by { |game| (game.home_goals - game.away_goals).abs }
    (blowout.home_goals - blowout.away_goals).abs
  end

  def percentage_home_wins
    home_wins = @games.find_all { |game| game.home_goals > game.away_goals}
    (home_wins.length.to_f / @games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.find_all { |game| game.away_goals > game.home_goals}
    (visitor_wins.length.to_f / @games.length.to_f).round(2)
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
