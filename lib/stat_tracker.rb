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
    @game_tracker.total_score.max
  end

  def lowest_total_score
    @game_tracker.total_score.min
  end

  def percentage_home_wins
    @game_tracker.percentage_wins('home')
  end

  def percentage_visitor_wins
    @game_tracker.percentage_wins('away')
  end

  def percentage_ties
    @game_tracker.percentage_wins('tie')
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
    @team_tracker.season_outcome(team_id, "best")
  end

  def worst_season(team_id)
    @team_tracker.season_outcome(team_id, "worse")
  end

  def average_win_percentage(team_id)
    @team_tracker.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_tracker.goals_scored(team_id, 'most')
  end

  def fewest_goals_scored(team_id)
    @team_tracker.goals_scored(team_id, 'fewest')
  end

  def favorite_opponent(team_id)
    @team_tracker.opponent_results(team_id, 'favorite')
  end
#Below are failing
  def rival(team_id)
    @team_tracker.opponent_results(team_id, 'rival')
  end

  def winningest_coach(season)
    @season_tracker.best_worst_coach(season, 'best')
  end

  def worst_coach(season)
    @season_tracker.best_worst_coach(season, 'worst')
  end

  def most_accurate_team(season)
    @season_tracker.accurate_team(season, 'most')
  end

  def least_accurate_team(season)
    @season_tracker.accurate_team(season, 'least')
  end

  def most_tackles(season)
    @season_tracker.tackle_results(season, 'most')
  end

  def fewest_tackles(season)
    @season_tracker.tackle_results(season, 'fewest')
  end
end
