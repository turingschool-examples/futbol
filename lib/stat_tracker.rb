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
end
