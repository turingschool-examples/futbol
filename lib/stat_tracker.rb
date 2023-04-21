require "csv"
require_relative "game"
require_relative "game_teams"
require_relative "game_statistics"

class StatTracker
  attr_reader :games,
              :game_teams,
              :teams

  def self.from_csv(files)
    StatTracker.new(files)
  end

  def initialize(files)
    @games = (CSV.open files[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    @game_teams = (CSV.open files[:game_teams], headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
    @teams = (CSV.open files[:teams], headers: true, header_converters: :symbol).map { |row| Teams.new(row) }
  end

  def highest_total_score
    @games.highest_total_score
  end

  def lowest_total_score
    @games.lowest_total_score
  end

  def percentage_home_wins
    @games.percentage_home_wins
  end

  def percentage_visitor_wins
    @games.percentage_visitor_wins
  end

  def percentage_ties
    @games.percentage_ties
  end

  def count_of_games_by_season
    @games.count_of_games_by_season
  end

  # def average_goals_per_game
  #   @games.average_goals_per_game
  # end

  def average_goals_per_game
    total_goals = games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    (total_goals.sum / games.length.to_f).round(2)
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def average_goals_by_season
    season_goals = Hash.new { |h, k| h[k] = { home_goals: 0, away_goals: 0, games_played: 0 } }
    
    games.each do |game|
      season_goals[game.season][:home_goals] += game.home_goals.to_i
      season_goals[game.season][:away_goals] += game.away_goals.to_i
      season_goals[game.season][:count_of_games_by_season]
    end
    
    season_goals.transform_values do |goals|
      total_goals = goals[:home_goals] + goals[:away_goals]
      require 'pry'; binding.pry
      total_goals.to_f / goals[:count_of_games_by_season]
    end
  end

  # def initialize(files)
  #   @game_stats = GameStatistics.new(files)
  # end

  #def method from game_statistics class
      #method ex: @games_stats.highest_score
  #end
end
