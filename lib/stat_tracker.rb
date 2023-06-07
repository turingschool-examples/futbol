require 'csv'

class StatTracker

  attr_reader :games,
              :teams,
              :game_by_team
  def initialize
    @games = []
    @teams = []
    @game_by_team = []
  end

  def from_csv(locations_hash)
    CSV.foreach(locations_hash[:games], headers: true, header_converters: :symbol) do |row|
      @games << Game.new(row)
    end
    CSV.foreach(locations_hash[:teams], headers: true, header_converters: :symbol) do |row|
      @teams << Team.new(row)
    end
    CSV.foreach(locations_hash[:game_by_team], headers: true, header_converters: :symbol) do |row|
      @game_by_team << Game_By_Team.new(row)
    end
  end
end