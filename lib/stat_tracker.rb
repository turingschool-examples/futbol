require_relative 'game_manager'
require_relative 'game_team_manager'
require_relative 'team_manager'


class StatTracker
  attr_reader :game_teams_manager, :game_manager, :team_manager
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    load_managers(locations)
  end

  def load_managers(locations)
    @game_manager = GameManager.new(locations, self)
    @team_manager = TeamManager.new(locations, self)
    @game_teams_manager = GameTeamManager.new(locations, self)
  end

  def team_info(team_id)
    @team_manager.team_info(team_id)
  end

  def winningest_coach(season_id)
    @game_team_manager.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    @game_team_manager.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    @game_team_manager.most_accurate_team(season_id)
  end

  def least_accurate_team(season_id)
    @game_team_manager.least_accurate_team(season_id)
  end

  def most_tackles(season_id)
    @game_team_manager.most_tackles(season_id)
  end

  def fewest_tackles(season_id)
    @game_team_manager.fewest_tackles(season_id)
  end
end
