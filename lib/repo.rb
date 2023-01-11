require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class Repo
  attr_reader :game_teams,
              :teams,
              :games

  def initialize(locations)
    @game_teams = GameTeam.read_file(locations[:game_teams])
    @teams = Team.read_file(locations[:teams])
    @games = Game.read_file(locations[:games])
  end
end