require_relative 'game'
require_relative 'game_team'
require_relative 'team'

class Classes
  attr_reader :games,
              :teams,
              :game_teams

    def initialize(locations)
      @games = CSV.foreach(locations[:games], headers: true).map {|info| Game.new(info)}
      @teams = CSV.foreach(locations[:teams], headers: true).map {|info| Team.new(info)}
      @game_teams = CSV.foreach(locations[:game_teams], headers: true).map {|info| GameTeam.new(info)}
    end
end