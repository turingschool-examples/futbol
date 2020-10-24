class GameStats
  attr_reader :stats

  def initialize(stats)
    @stats = stats
  end

  def convert_to_i(array)
    array.map(&:to_i)
  end
  # def sum_data(data_key)
  #   @stats[data_key].map do |number|
  #     number.to_i
  #   end.sum
  # end


end