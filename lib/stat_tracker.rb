require 'CSV'
require './lib/team'
require './lib/game'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games_file, teams_, game_teams)
    @games_file = games_file
    @teams_file = teams_file
    @game_teams_file = game_teams_file
  end

  def self.from_csv(locations_params)
    games_file = locations_params[:games]
    teams_file = locations_params[:teams]
    game_teams_file = locations_params[:game_teams]

    StatTracker.new(games_file, teams_file, game_teams_file)
  end
end
