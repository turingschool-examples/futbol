require './lib/statistics/game_statistics'
require './lib/statistics/league_statistics'
require './lib/statistics/season_statistics'
require './lib/statistics/team_statistics'
require './lib/managers/game_manager'
require './lib/managers/game_teams_manager'
require './lib/managers/team_manager'

class StatTracker
  attr_reader :season_statistics

  def initialize(locations)
    game_manager = GameManager.new(locations[:games])
    team_manager = TeamManager.new(locations[:teams])
    game_team_manager = GameTeamsManager.new(locations[:game_teams])
    @season_statistics = SeasonStatistics.new(game_team_manager)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Game Statistics

  # League Statistics

  # Season Statistics
  def winningest_coach(season_id)
    @season_statistics.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    @season_statistics.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    @season_statistics.most_accurate_team(season_id)
    # needs to reference team_statistics (team_id -> team_name)
  end

  def least_accurate_team(season_id)
    @season_statistics.least_accurate_team(season_id)
    # needs to reference team_statistics (team_id -> team_name)
  end

  def most_tackles(season_id)
    @season_statistics.most_tackles(season_id)
    # needs to reference team_statistics (team_id -> team_name)
  end

  def fewest_tackles(season_id)
    @season_statistics.fewest_tackles(season_id)
    # needs to reference team_statistics (team_id -> team_name)
  end

  # Team Statistics
end
