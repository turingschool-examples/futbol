require 'CSV'
require 'pry'
require_relative './games'
require_relative './teams'
require_relative './game_teams'
class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  
  end
  def self.from_csv(locations)
    # Read each CSV file using the correct paths
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol).map do |row|
      Games.new(row) 
    end
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol).map do |row|
      Teams.new(row)
    end
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol).map do |row|
      GameTeams.new(row)
    end

    # Create a new instance of StatTracker
    # stat_tracker = StatTracker.new(locations)
    StatTracker.new(games, teams, game_teams)
    # Return the instance
  end
  
  def highest_total_score
    @games.map { |game| game.home_goals.to_i + game.away_goals.to_i }.max
  end

  def lowest_total_score
    @games.map {|game| game.home_goals + game.away_goals }.min
  end

  def percentage_home_wins
    total_games = @games.length.to_f
    home_wins = @games.count { |game| game.home_goals.to_i > game.away_goals.to_i }
  
    (home_wins / total_games).round(2)
  end

  def percentage_visitor_wins
    total_games = @games.length.to_f
    away_wins = @games.count {|game| game.home_goals.to_i < game.away_goals.to_i}

    (away_wins / total_games).round(2)
  end

  def percentage_ties
    total_games = @games.length.to_f
    ties = @games.count {|game| game.home_goals.to_i == game.away_goals.to_i}

    (ties / total_games).round(2)
  end

  def count_of_games_by_season
    hash = {}
    @games.each do |season|
      hash[:season] = []
      @games.count
    end
  end
end