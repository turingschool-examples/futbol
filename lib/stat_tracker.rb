require 'csv'
require_relative 'game'

class StatTracker
  def self.from_csv(file_path)
    game_path = file_path[:games]
    team_path = file_path[:teams]
    game_team_path = file_path[:game_teams]

    StatTracker.new(game_path, team_path, game_team_path)
  end

  attr_reader :game_path, :team_path, :game_team_path

  def initialize(game_path, team_path, game_team_path)
    @game_path =  game_path
    @team_path = team_path
    @game_team_path = game_team_path
  end

  def games
    Game.from_csv(@game_path)
    Game.all_games
  end
end
