require 'pry'
require 'CSV'
require './lib/games_collection'
require './lib/teams_collection'
require './lib/games_teams_collection'

class StatTracker
  attr_reader :locations

  def initialize(locations)
    @locations = locations

    @games_file = GamesCollection.new(@locations[:games])
    @teams_file = TeamsCollection.new(@locations[:teams])
    @game_teams_file = GamesTeamsCollection.new(@locations[:game_teams])
    @read_games = @games_file.read_file
    @read_teams = @teams_file.read_file
    @read_game_teams = @game_teams_file.read_file

  end

  def self.from_csv(files)
    StatTracker.new(files)
  end

  def count_of_teams
    @read_teams.size
  end
end
