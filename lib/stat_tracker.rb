require 'csv'
require_relative '../lib/game_manager'
require_relative '../lib/team_manager'
require_relative '../lib/game_teams_manager'
require_relative '../lib/game'
require_relative '../lib/team'
require_relative '../lib/game_teams'

class StatTracker
  attr_reader :game_manager, :team_manager, :game_teams_manager

  def initialize(game_path, team_path, game_teams_path)
    @game_manager = GameManager.new(game_path, self)
    @team_manager = TeamManager.new(team_path, self)
    @game_teams_manager = GameTeamsManager.new(game_teams_path, self)
  end

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    new(game_path, team_path, game_teams_path)
  end

  # # ----------SeasonStats
  #
  def winningest_coach(season)
    @game_teams_manager.winningest_coach(season)
  end
  #
  def worst_coach(season)
    @game_teams_manager.worst_coach(season)
  end
  #
  def most_accurate_team(season)
    @game_teams_manager.most_accurate_team(season)
  end
  #
  def least_accurate_team(season)
    @game_teams_manager.least_accurate_team(season)
  end
  #
  def most_tackles(season)
    @game_teams_manager.most_tackles(season)
  end
  #
  def fewest_tackles(season)
    @game_teams_manager.fewest_tackles(season)
  end

  # ----------LeaugeStats
  def count_of_teams
    @game_manager.count_of_teams
  end

  def best_offense
    @game_manager.best_offense
  end

  def worst_offense
    @game_manager.worst_offense
  end

  def highest_scoring_visitor
    @game_manager.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_manager.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @game_manager.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_manager.lowest_scoring_home_team
  end

  def initialize_team_stats_hash
    @team_manager.initialize_team_stats_hash
  end

#-------------TeamStats
  def team_info(team_id)
    @team_manager.team_info(team_id)
  end

  def best_season(team_id)
    @game_teams_manager.best_season(team_id)
  end

  def worst_season(team_id)
    @game_teams_manager.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_teams_manager.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_teams_manager.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_teams_manager.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @game_teams_manager.favorite_opponent(team_id)
  end

  def rival(team_id)
    @game_teams_manager.rival(team_id)
  end
end
