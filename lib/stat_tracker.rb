require_relative './stat_tracker'
require 'csv'
class StatTracker

  # def self.from_csv(locations)
  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end
  # end
  
  def highest_total_score
    max = 0
    @games.each do |row|
      total = row[:home_goals].to_i + row[:away_goals].to_i
      max = [max, total].max
    end
    max
  end
  
  def lowest_total_score
    min = 10
    @games.each do |row|
      score = row[:home_goals].to_i + row[:away_goals].to_i
      min = [min, score].min
    end
    min
  end

  def average_goals_by_season
    avg_goals = Hash.new { |h, k| h[k] = Hash.new(0) }
    @games.each do |game|
      season = game[:season].to_i; goals = game[:home_goals].to_i + game[:away_goals].to_i
      avg_goals[season][:goals] += goals
      avg_goals[season][:games] += 1
    end
    avg_goals.transform_values do |season| 
      season[:goals].fdiv(season[:games]).round(2) 
    end
  end

  def percent_home_wins
    home_wins = 0
    @games.each do |game|
      home_wins += 1 if game[:home_goals].to_i > game[:away_goals].to_i
    end
    home_wins.fdiv(@games.length - 1).round(2)
  end

  def percent_away_wins
    away_wins = 0
    @games.each do |game|
      away_wins += 1 if game[:away_goals].to_i > game[:home_goals].to_i
    end
    away_wins.fdiv(@games.length - 1).round(2)
  end

  def percent_ties
    ties = 0
    @games.each do |game|
      ties += 1 if game[:away_goals].to_i == game[:home_goals].to_i
    end
    ties.fdiv(@games.length - 1).round(2)
  end

  def count_of_games_by_season
    season_games = Hash.new(0)
    @games.each do |game|
      season = game[:season].to_i
      season_games[season] += 1
    end
    season_games
  end

  def average_goals_per_game
    goals = 0
    @games.each do |game|
      goals += game[:home_goals].to_i + game[:away_goals].to_i
    end
    goals.fdiv(@games.length - 1).round(2)
  end
end