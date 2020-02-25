require_relative './game_collection'
require 'CSV'

class StatTracker

  attr_reader :game_path, :team_path, :game_team_path

  def initialize(game_path, team_path, game_team_path)
    @game_path = game_path
    @team_path = team_path
    @game_team_path = game_team_path
    @games = game_collection.games
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def game_collection
    GameCollection.new(@game_path)
  end

  def highest_total_score
    @games.max_by { |game| game.total_goals }.total_goals
  end

  def lowest_total_score
    @games.min_by { |game| game.total_goals }.total_goals
  end

  def biggest_blowout
    game_goals_ranges = []
    game_collection.games.each do |game|
      game_goals_ranges << (game.home_goals - game.away_goals).abs
    end
    game_goals_ranges.max
  end

  def percentage_home_wins
    home_wins = @games.count { |game| game.home_win? }
    (home_wins.to_f / game_collection.games.length).round(2)
  end

  def percentage_visitor_wins
    away_wins = @games.count { |game| game.away_win? }
    (away_wins.to_f / game_collection.games.length).round(2)
  end

  def percentage_ties
    ties = @games.count { |game| game.tie? }
    (ties.to_f / @games.length).round(2)
  end

  def count_of_games_by_season
    @games.reduce(Hash.new(0)) do |acc, game|
      acc[game.season] += 1
      acc
    end
  end

  def average_goals_per_game
    (@games.map {|game| game.total_score}.sum / @games.length.to_f).round(2)
  end

  def average_goals_per_season
    @games.reduce(Hash.new(0)) do |acc, game|
      acc[game.season] += (game.total_goals / count_of_games_by_season[game.season].to_f).round(2)
      acc
    end
  end
end
