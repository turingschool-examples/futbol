require 'csv'
require './lib/game.rb'

class GameStatistics
  attr_reader :games

  def initialize(games = [])
    @games = games
  end

  def self.from_csv(filepath)
    games = []

    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      games << Game.new(row)
    end
    
    new(games)
  end

  def highest_total_score
    highest_score = 0
    @games.each do |game| 
      total_score = game.home_goals + game.away_goals 
      highest_score = total_score if total_score > highest_score
    end
    highest_score
  end

  def lowest_total_score
    lowest_score = Float::INFINITY
    @games.each do |game| 
      total_score = game.home_goals + game.away_goals 
      lowest_score = total_score if total_score < lowest_score
    end
    lowest_score == Float::INFINITY ? 0 : lowest_score
  end 

  def percentage_home_wins 
    total_games = @games.size 
    home_wins = @games.count { |game| game.home_goals > game.away_goals }
    (home_wins.to_f / total_games * 100).round(2)
  end

  def percentage_away_wins
    total_games = @games.size 
    away_wins = @games.count { |game| game.away_goals > game.home_goals }
    (away_wins.to_f / total_games * 100).round(2)
  end

  def percentage_ties
    total_games = @games.size 
    tie = @games.count { |game| game.away_goals == game.home_goals }
    (tie.to_f / total_games * 100).round(2)
  end

  def count_of_games_by_season
    count_by_season = Hash.new(0)
    games.each do |game|
      count_by_season[game.season] += 1
    end
    count_by_season
  end

  def average_goals_per_game
    total_goals = @games.sum { |game| game.away_goals + game.home_goals }
    total_games = @games.size

    average_goals = (total_goals.to_f / total_games).round(2)

    average_goals
  end

  def average_goals_by_season
    stats = Hash.new { |hash, key| hash[key] = { total_goals: 0, game_count: 0 } }

    @games.each do |game|
      season = game.season
      total_goals = game.away_goals + game.home_goals

      stats[season][:total_goals] += total_goals
      stats[season][:game_count] += 1
    end

    averages_by_season = {}
    stats.each do |season, stats|
      average_goals = stats[:total_goals].to_f / stats[:game_count]
      averages_by_season[season] = average_goals.round(2)
    end

    averages_by_season    
  end

end

