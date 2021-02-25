require 'CSV'

class StatTracker
  attr_reader :games_hash, :games

  def initialize(locations)
    @game_manager = GamesManager.new(
      locations[:games],
      self
    )
    @games = CSV.parse(File.read(locations[:games]), headers: true)
    @games_hash = {}
    @teams = CSV.parse(File.read(locations[:teams]), headers: true)
    @game_teams = CSV.parse(File.read(locations[:game_teams]), headers: true)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # def games_hash
  #   @games_hash = @games.to_h
  # end
end
