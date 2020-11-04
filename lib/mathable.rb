module Mathable
  def percentage(numerator, denominator, round)
    (numerator.to_f / denominator).round(round)
  end
end
