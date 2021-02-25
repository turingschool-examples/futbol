require 'CSV'

class StatTracker
  attr_reader :games, :game_teams, :teams
  def initialize(locations)
      @games = CSV.parse( File.read( locations[:games] ), headers: true)
      @game_teams = CSV.parse( File.read(locations[:game_teams] ), headers: true)
      @teams = CSV.parse( File.read( locations[:teams] ), headers: true)
  end

  def self.from_csv(locations)
    StatTracker.new
    # @games = CSV.parse( File.read( locations[:games] ), headers: true)
    # @game_teams = CSV.parse( File.read(locations[:game_teams] ), headers: true)
    # @teams = CSV.parse( File.read( locations[:teams] ), headers: true)
  end
end
