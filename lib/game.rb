class Game
  attr_reader :stat_hash

  def initialize()
    @stat_hash = {}
  end

  def create_stat_hash_keys(game_data)
    index = 0
    game_data[0].size.times do
      @stat_hash[game_data[0][index]] = []
      key = @stat_hash[game_data[0][index]]
      create_stat_hash_values(game_data, index, key)
      index += 1
    end
  end

  def create_stat_hash_values(game_data, index, key)
    line_index = 1
    number = game_data.size - 1
    number.times do
      key << game_data[line_index][index]
      line_index += 1
    end
  end
end
