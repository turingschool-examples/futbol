require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize
    @games = nil
    @teams = nil
    @game_teams = nil
  end

  def self.from_csv(locations)
    @games = CSV.read(locations[:games])
    @teams = CSV.read(locations[:teams])
    @game_teams = CSV.read(locations[:game_teams])
  end

end
