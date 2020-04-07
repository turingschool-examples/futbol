require 'csv'
# require_relative '../lib/game'
# require_relative '../lib/team'
# require_relative '../lib/game_team'
require_relative './game'
require_relative './team'
require_relative './game_team'


class StatTracker

  def self.from_csv(file_paths)
    game_teams_path = file_paths[:game_teams]
    games_path = file_paths[:games]
    teams_path = file_paths[:teams]

    self.new(game_teams_path, games_path, teams_path)

  end

  attr_reader :game_teams_path,
              :games_path,
              :teams_path,
              :games,
              :teams,
              :game_teams

  def initialize(game_teams_path, games_path, teams_path)
    @game_teams_path = game_teams_path
    @games_path = games_path
    @teams_path = teams_path
    create_games
    create_teams
    create_game_teams
  end

  def create_games
    @games = Game.from_csv(@games_path)
  end

  def create_teams
    @teams = Team.from_csv(@teams_path)
  end

  def create_game_teams
    @game_teams = GameTeam.from_csv(@game_teams_path)
  end

  def all_teams
    Team.all
  end
end
