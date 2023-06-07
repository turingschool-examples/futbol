require './lib/games'
require './lib/teams'
require './lib/game_teams'
require './lib/raw_stats'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
  # Variable names for methods to be implimented
  # @game_stats = GameStats.new(data)
  # How do we want to get these objects to have statistics characteristics (for connecting raw stats)?
  # class GameStats < RawStats
  end

  # Implement the remaining methods for statistics calculations
  # ...
end
