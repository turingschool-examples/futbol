require './lib/game_collection'
require './lib/game_teams_collection'

class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    team_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_teams_path, game_path)
    @game_teams = GameTeams.new(game_teams_path)
    @games = Games.new(game_path)
  end



end
