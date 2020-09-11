require 'csv'

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
end

    # game_manager = CSV.read(locations[:games], headers:true)
    # team_manager = CSV.read(locations[:teams], headers:true)
    # game_teams_manager = CSV.read(locations[:game_teams], headers:true)