module Calculable
  def average(num1, total_count)
    (num1 / total_count).round(2)
  end

  def percent(num1, total_count)
    ((num1 / total_count) * 100).round(2)
  end
end
