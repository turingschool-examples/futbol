require 'pry'
class GameStatistics

  attr_reader :stat_hash

  def initialize(game_stats)
    @stat_hash = game_stats[:stat_hash]
  end

   
end
