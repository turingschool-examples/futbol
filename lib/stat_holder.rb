require_relative 'stat_tracker'
require_relative 'games'
require_relative 'game_teams'
require_relative 'league'
class StatHolder
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
 
    @games = CSV.foreach(locations[:games], headers: true).map {|info| Game.new(info)}
    @teams = CSV.foreach(locations[:teams], headers: true).map {|info| League.new(info)}
    @game_teams = CSV.foreach(locations[:game_teams], headers: true).map {|info| GameTeam.new(info)}
    
  end
end