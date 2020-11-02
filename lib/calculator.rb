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
end
