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
    @team_manager = TeamManager.new(locations, self)
    @game_manager = GameManager.new(locations, self)
    @game_teams_manager = GameTeamManager.new(locations, self)
  end

  def team_info(team_id)
    @team_manager.team_info(team_id)
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
end
