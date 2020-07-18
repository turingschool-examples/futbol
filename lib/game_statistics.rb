require 'pry'
class GameStatistics

  attr_reader :stat_hash

  def initialize()
    @stat_hash = {}
  end

  def create_stat_hash_keys(game_stats)
    index = 0
    game_stats[0].size.times do
      @stat_hash[game_stats[0][index]] = 0
      index += 1
    end

  end

  def create_stat_hash_values(stat_hash_keys)

  end
end
