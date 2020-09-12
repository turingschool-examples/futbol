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
    @game_manager = GameManager.new(locations, self)
    @team_manager = TeamManager.new(locations[:teams], self)
    @game_teams_manager = GameTeamManager.new(locations, self)
  end

  def team_info(team_id)
    @team_manager.team_info(team_id)
  end
end
