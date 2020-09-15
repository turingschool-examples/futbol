module Mathable

  def sort_percentages(numerator, denominator)
    numerator.sort_by do |team_name, statistic|
      statistic.to_f / denominator[team_name]
    end
  end
end
