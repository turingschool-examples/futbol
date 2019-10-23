require './lib/games_collection'
require './lib/game_team_collection'
require './lib/teams_collection'

class StatTracker

  def self.from_csv(file_pathsa)
    game_teams_path = file_paths[:game_teams]
    games_path = file_path[:games]
    teams_path = file_path[:teams]

  StatTracker.new(game_teams_path, game_path, teams_path)
  end

  def initialize(game_teams_path, games_path, teams_path)
    @game_teams_path = game_teams
    @games_path = games_path
    @teams_path = teams_path
  end

  def game_teams
    GamesTeamsCollection.new(@game_teams_path)
  end

  def game
    GamesCollection.new(@game_path)
  end

  def teams
    TeamsCollection.new(@teams_path)
  end
