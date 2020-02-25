require_relative './modules/game_statistics'
require_relative './modules/league_statistics'
require_relative './modules/season_statistics'
require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class StatTracker
  include GameStatistics
  include LeagueStatistics
  include SeasonStatistcs

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new(game_path, team_path, game_teams_path)
  end
  attr_reader :games, :teams, :game_teams
  def initialize(game_path, team_path, game_teams_path)
    @games = Game.create_games(game_path)
    @teams = Team.create_teams(team_path)
    @game_teams = GameTeam.create_game_teams(game_teams_path)
  end

end
