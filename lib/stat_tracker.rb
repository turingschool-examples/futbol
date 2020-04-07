require 'csv'

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
              :teams


  def initialize(game_teams_path, games_path, teams_path)
    @game_teams_path = game_teams_path
    @games_path = games_path
    @teams_path = teams_path
    create_games
    create_teams
  end

  def create_games
    @games = Game.from_csv(@games_path)
  end

  def create_teams
    @teams = Team.from_csv(@teams_path)
  end
end
