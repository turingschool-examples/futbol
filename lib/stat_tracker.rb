require "csv"
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'game_team_stats'
require_relative 'league_stats'
require_relative 'game_stats'
require_relative 'season_stats'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams, :games_array

  def initialize(locations)
    @game_team_stats = GameTeamStats.new(locations)
    @league_stats = LeagueStats.new(locations)
    @game_stats = GameStats.new(locations)
    @season_stats = SeasonStats.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Team Statistics
  def team_info(team_id)
    @game_team_stats.team_info(team_id)
  end

  def season_games(game_id)
    @game_team_stats.season_games(game_id)
  end

  def best_season(team_id)
    @game_team_stats.best_season(team_id)
  end

  def worst_season(team_id)
    @game_team_stats.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_team_stats.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_team_stats.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_team_stats.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @game_team_stats.favorite_opponent(team_id)
  end

  def rival(team_id)
    @game_team_stats.rival(team_id)
  end

#league stats
  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  #Game Stats
  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end 

  #season_stats

  def winningest_coach(season_id)
    @season_stats.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    @season_stats.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    @season_stats.most_accurate_team
  end

  def least_accurate_team(season_id)
    @season_stats.least_accurate_team(season_id)
  end

  def most_tackles(season_id)
    @season_stats.most_tackles(season_id)
  end

  def fewest_tackles(season_id)
    @season_stats.fewest_tackles
  end
end
