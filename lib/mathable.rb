module Mathable
  def find_percent(numerator, denominator)
    (numerator / denominator.to_f).round(2)
  end
end
