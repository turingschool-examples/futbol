require "csv"

class StatTracker
  attr_reader :game_stats
  
  def self.from_csv(files)
    StatTracker.new
  end

  def initialize(files)
    @game_stats = GameStats.new(files)
  end
end