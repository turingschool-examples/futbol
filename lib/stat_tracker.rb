require "csv"
require_relative "game"
require_relative "game_teams"
require_relative "game_statistics"
require_relative "./teams"
#lg note: I noticed the stat_helper file paths contain "./" ; which is correct?

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

  def average_goals_per_game
    @games.average_goals_per_game
  end

  def average_goals_by_season
    @games.average_goals_by_season
  end

  def count_of_teams
    @teams.count_of_teams
  end

  def offense_avg
    @teams.offense_avg
  end
# lg note: ^ this is a helper method for the two methods below. Do we want to include it here in the stat_tracker? 

  def best_offense
    @teams.best_offense
  end

  def worst_offense
    @teams.worst_offense
  end

  # def initialize(files)
  #   @game_stats = GameStatistics.new(files)
  # end

  #def method from game_statistics class
      #method ex: @games_stats.highest_score
  #end
end
