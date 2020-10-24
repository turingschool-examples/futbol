class GameStats
  attr_reader :stats

  def initialize(stats)
    @stats = stats
  end

  def convert_to_i(array)
    array.map(&:to_i)
  end

  def sum_data(data_key)
    convert_to_i(@stats[data_key]).sum
  end


end