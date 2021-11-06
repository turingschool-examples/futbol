require 'csv'
require 'simplecov'
require_relative './game_stats'
require_relative './league_stats.rb'
require_relative './season_stats.rb'
require_relative './team_stats.rb'

SimpleCov.start

class StatTracker
  attr_accessor :game_teams_path, :teams_path, :games_path

  def initialize(locations)
    # @game_teams_path = game_teams(locations[:game_teams])
    # @teams_path = teams(locations[:teams])
    @games_path = games(locations[:games])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def games(game_stats)
    rows = CSV.read(game_stats, headers: true)
    rows.map do |row|
      GameStats.new(row)
    end
  end

  def teams(team_stats)
    rows = CSV.read(game_stats, headers: true)
    rows.map do |row|
      TeamStats.new(row)
    end
  end


    def game_teams(game_teams_stats)
      rows = CSV.read(game_stats, headers: true)
      rows.map do |row|
        GameTeams.new(row)
      end
    end

  # def highest_total_score
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.highest_total_score
  # end
  #
  # def lowest_total_score
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.lowest_total_score
  # end
  #
  # def percentage_home_wins
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.percentage_home_wins
  # end
  #
  # def percentage_visitor_wins
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.percentage_visitor_wins
  # end
  #
  # def percentage_ties
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.percentage_ties
  # end
  #
  # def count_of_games_by_season
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.count_of_games_by_season
  # end
  #
  # def average_goals_per_game
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.average_goals_per_game
  # end
  #
  # def average_goals_by_season
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.average_goals_per_season
  # end
  #
  #
  # def count_of_teams
  #   league_stats = LeagueStats.new(@game_teams_path)
  #   league_stats.count_of_teams
  # end


end
