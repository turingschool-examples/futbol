require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games      = CSV.read(locations[:games], headers: true)
    @teams      = CSV.read(locations[:teams], headers: true)
    @game_teams = CSV.read(locations[:game_teams], headers: true)
  end



end
