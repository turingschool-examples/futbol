module Mathable
  def min_average_hash_values(hash_1, hash_2)
    averages = hash_1.merge(hash_2) do |key, hash_1_value, hash_2_value|
      to_percent(hash_1_value, hash_2_value)
    end
    (averages.min_by {|team_id, average| average}).first
  end

  def max_average_hash_values(hash_1, hash_2)
    averages = hash_1.merge(hash_2) do |key, hash_1_value, hash_2_value|
      to_percent(hash_1_value, hash_2_value)
    end
    (averages.max_by {|team_id, average| average}).first
  end

  def sum_values(key_value_arr)
    sum = Hash.new(0)
    key_value_arr.each { |key, value| sum[key] += value }
    sum
  end

  def to_percent(numerator, denominator)    #helper, module?
    (numerator.to_f / denominator).round(2)
  end

  def home_and_away_goals_sum
    games.map { |game| game.total_goals }
  end
end