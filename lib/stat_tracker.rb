require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path, :game_teams, :games, :teams

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_teams = GameTeam.from_csv(@game_teams_path)
    @games = Game.from_csv(@game_path)
    @teams = Team.from_csv(@team_path)
  end

  def worst_fans
  end
end
