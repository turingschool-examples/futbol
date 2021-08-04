module Mathable
  extend self

  def compute_average (sum, total)
    sum / total
  end

  def percentage(sum, total)
    compute_average(sum, total) * 100
  end

  def add (value1, value2)
    value1 + value2
  end

  def subtract (value1, value2)
    value1 - value2
  end
end
