require 'csv'
require_relative 'team_collection'
require_relative 'game_stats_collection'

class StatTracker
  attr_reader :games, :teams, :game_stats

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol)
    game_stats = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_stats)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_stats = game_teams_path
    @game_stats_collection = GameStatsCollection.new("./data/game_teams.csv")
  end

  def count_of_teams
    @teams.length
  end

  def best_offense
    @game_stats_collection.best_offense
  end

  def worst_offense
    @game_stats_collection.worst_offense
  end

  def highest_scoring_visitor
    @game_stats_collection.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_stats_collection.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @game_stats_collection.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_stats_collection.lowest_scoring_home_team
  end
end
