module Mathable
  def min_average_hash_values(hash_1, hash_2)
    averages = hash_1.merge(hash_2) do |key, hash_1_value, hash_2_value|
      get_percentage(hash_1_value, hash_2_value)
    end
    (averages.min_by {|team_id, average| average}).first
  end

  def max_average_hash_values(hash_1, hash_2)
    averages = hash_1.merge(hash_2) do |key, hash_1_value, hash_2_value|
      get_percentage(hash_1_value, hash_2_value)
    end
    (averages.max_by {|team_id, average| average}).first
  end

  def sum_values(key_value_arr)
    sum = Hash.new(0)
    key_value_arr.each { |key, value| sum[key] += value }
    sum
  end

  def get_percentage(numerator, denominator, round_to = 2)
    (numerator.to_f / denominator).round(round_to)
  end
end
