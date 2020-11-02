module Calculator

  def max(values_hash)
    max_pair = values_hash.max_by do |key, values|
      values
    end
    max_pair
  end

  def min(values_hash)
    min_pair = values_hash.min_by do |key, values|
      values
    end
    min_pair
  end

  def avg(values_hash)
    values_hash.transform_values do |value|
      value[:wins].to_f / value[:total]
    end
  end

  def min_avg(hash)
    min(avg(hash))
  end

  def max_avg(hash)
    max(avg(hash))
  end

  def win_pct(hash)
    value = hash.values.each_with_object(Hash.new(0)) do |data_set, sum|
      sum[:wins] += data_set[:wins]
      sum[:total] += data_set[:total]
    end
    (value[:wins].to_f / value[:total]).round(2)
  end
end
