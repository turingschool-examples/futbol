module Divisable

  def average(sum, total)
    (sum / total).round(2)
  end

  def percentage(sum, total)
    ((sum / total) * 100).round(2)
  end
end
