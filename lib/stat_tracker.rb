require 'csv'
require_relative 'games_collection'
require_relative 'game_teams_collection'
require_relative 'teams_collection'

class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path

  def self.from_csv(file_paths)
    games_path = file_paths[:games]
    teams_path = file_paths[:teams]
    games_teams_path = file_paths[:game_teams]

    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    @games_path = games_path
    @teams_path = teams_path
    @game_teams_path = game_teams_path
  end

  def game_teams_collection
    GameTeamsCollection.new(@game_teams_path)
  end


  def games_collection
    GamesCollection.new(@games_path)
  end

  def teams_collection
    TeamsCollection.new(@teams_path)
  end
end
