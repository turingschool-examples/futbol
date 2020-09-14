require_relative 'game_manager'
require_relative 'game_team_manager'
require_relative 'team_manager'


class StatTracker
  attr_reader :game_teams_manager, :game_manager, :team_manager
  def self.from_csv(locations) # I need a test
    StatTracker.new(locations)
  end

  def initialize(locations) # I maybe need a test?
    load_managers(locations)
  end

  def load_managers(locations) # I need a test
    @game_manager = GameManager.new(locations[:games], self)
    @team_manager = TeamManager.new(locations[:teams], self)
    @game_teams_manager = GameTeamManager.new(locations[:game_teams], self)
  end

  def team_info(team_id)
    @team_manager.team_info(team_id)
  end

  def game_ids_by_team(team_id)
    @game_teams_manager.game_ids_by_team(team_id)
  end

  def game_team_info(game_id)
    game_teams_manager.game_team_info(game_id)
  end

  def game_info(game_id)
    game_manager.game_info(game_id)
  end

  def average_win_percentage(team_id)
    team_manager.average_win_percentage(team_id)
  end

  def favorite_opponent(team_id)
    team_manager.favorite_opponent(team_id)
  end

  def rival(team_id)
    team_manager.rival(team_id)
  end

  def most_goals_scored(team_id)
    team_manager.most_goals_scored(team_id)
  end
end
