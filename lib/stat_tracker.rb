# require './lib/csv_helper'
require_relative 'game_statistics'
require_relative 'game_team'
require_relative 'game'
require_relative 'league_statistics'
require_relative 'season_statistics'
require_relative 'stats_helper'
require_relative 'team'

class StatTracker
  
  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @game_teams = locations[:game_teams]

    GameStatistics.set_gamecsv(@games)
    League_Statistics.set_leagueCSV(@teams, @games, @game_teams)
    SeasonStatistics.set_seasoncsv(@games, @game_teams, @teams)
  end

  def self.from_csv(locations)
    self.new(locations)
  end

  def highest_total_score
    GameStatistics.highest_total_score
  end

  def lowest_total_score
    GameStatistics.lowest_total_score
  end

  def percentage_home_wins
    GameStatistics.percentage_home_wins
  end

  def percentage_visitor_wins
    GameStatistics.percentage_visitor_wins
  end

  def percentage_ties
    GameStatistics.percentage_ties
  end

  def count_of_games_by_season
    GameStatistics.count_of_games_by_season
  end

  def average_goals_per_game
    GameStatistics.average_goals_per_game
  end

  def average_goals_by_season
    GameStatistics.average_goals_by_season
  end

  def count_of_teams
    League_Statistics.count_of_teams
  end

  def best_offense
    League_Statistics.best_offense
  end

  def worst_offense
    League_Statistics.worst_offense
  end

  def highest_scoring_visitor
    League_Statistics.highest_scoring_visitor
  end

  def highest_scoring_home_team
    League_Statistics.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    League_Statistics.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    League_Statistics.lowest_scoring_home_team
  end

  def winningest_coach(season)
    SeasonStatistics.winningest_coach(season)
  end

  def worst_coach(season)
    SeasonStatistics.worst_coach(season)
  end

  def most_accurate_team(season)
    SeasonStatistics.most_accurate_team(season)
  end

  def least_accurate_team(season)
    SeasonStatistics.least_accurate_team(season)
  end

  def most_tackles(season)
    SeasonStatistics.most_tackles(season)
  end

  def fewest_tackles(season)
    SeasonStatistics.fewest_tackles(season)
  end
end