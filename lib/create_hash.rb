class CreateHash
  attr_reader :stat_hash

  def initialize()
    @stat_hash = {}
  end

  def create_stat_hash_keys(game_stats)
    index = 0
    game_stats[0].size.times do
      @stat_hash[game_stats[0][index]] = []
      key = @stat_hash[game_stats[0][index]]
      create_stat_hash_values(game_stats, index, key)
      index += 1
    end
  end

  def create_stat_hash_values(game_stats, index, key)
    line_index = 1
    number = game_stats.size - 1
    number.times do
      key << game_stats[line_index][index]
      line_index += 1
    end
  end
end
