require_relative './game'
require_relative './team'
require_relative './game_teams'

require_relative './game_collection'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)

    @games = GameCollection.new(info[:games])
    @teams = info[:teams]
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistics Methods
  def highest_total_score
    games.all.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.max
  end

  def lowest_total_score
    games.all.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.min
  end

  def percentage_home_wins
    home_wins = 0
    games.all.each do |game|
      home_wins += 1 if game.home_goals.to_i > game.away_goals.to_i
    end
    (home_wins.to_f / games.all.size).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    games.all.each do |game|
      visitor_wins += 1 if game.away_goals.to_i > game.home_goals.to_i
    end
    (visitor_wins.to_f / games.all.size).round(2)
  end

  def percentage_ties
    ties = 0
    games.all.each do |game|
      ties += 1 if game.away_goals.to_i == game.home_goals.to_i
    end
    (ties.to_f / games.all.size).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    games.all.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    average_goals = 0
    games.all.each do |game|
      average_goals += game.away_goals.to_i
      average_goals += game.home_goals.to_i
    end
    (average_goals.to_f / games.all.count).round(2)
  end

  def initialize
    @games = info[:games]
    @teams = info[:teams]
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistic methods


  # League Statistic methods


  # Season Statistic methods


  # Team Statistic methods

end
