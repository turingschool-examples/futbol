module Manageable
  def find_percent(numerator, denominator)
    return 0.0 if denominator == 0
    (numerator / denominator.to_f * 100).round(2)
  end

  def ratio(numerator, denominator)
    (numerator.to_f / denominator).round(2)
  end
end
