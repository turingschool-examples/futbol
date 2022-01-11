require 'csv'
require_relative './statistics'
require_relative './game_tracker'
require_relative './team_tracker'
require_relative './season_tracker'
require_relative './game_team_tracker'

class StatTracker
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_tracker = GameTracker.new(locations)
    @team_tracker = TeamTracker.new(locations)
    @season_tracker = SeasonTracker.new(locations)
    @game_team_tracker = GameTeamTracker.new(locations)
  end

  def highest_total_score
    @game_tracker.highest_total_score
  end

  def lowest_total_score
    @game_tracker.lowest_total_score
  end

  def percentage_home_wins
    @game_tracker.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_tracker.percentage_visitor_wins
  end

  def percentage_ties
    @game_tracker.percentage_ties
  end

  def count_of_games_by_season
    @game_tracker.count_of_games_by_season
  end

  def average_goals_per_game
    @game_tracker.average_goals_per_game
  end

  def average_goals_by_season
    @game_tracker.average_goals_by_season
  end

  def count_of_teams
    @game_team_tracker.count_of_teams
  end

  def best_offense
    @game_team_tracker.best_offense
  end

  def worst_offense
    @game_team_tracker.worst_offense
  end

  def highest_scoring_visitor
    @game_team_tracker.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_team_tracker.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @game_team_tracker.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_team_tracker.lowest_scoring_home_team
  end

  def team_info(team_id)
    @team_tracker.team_info(team_id)
  end

  def best_season(team_id)
    @team_tracker.best_season(team_id)
  end

  def worst_season(team_id)
    @team_tracker.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @team_tracker.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_tracker.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_tracker.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_tracker.favorite_opponent(team_id)
  end
#Below are failing
  def rival(team_id)
    @team_tracker.rival(team_id)
  end

  def winningest_coach(season)
    @season_tracker.winningest_coach(season)
  end

  def worst_coach(season)
    @season_tracker.worst_coach(season)
  end

  def most_accurate_team(season)
    @season_tracker.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @season_tracker.least_accurate_team(season)
  end

  def most_tackles(season)
    @season_tracker.most_tackles(season)
  end

  def fewest_tackles(season)
    @season_tracker.fewest_tackles(season)
  end
end
