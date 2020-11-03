module Divisable

  def average(sum, total)
    (sum / total.to_f).round(2)
  end

  def percentage(sum, total)
    ((sum / total.to_f) * 100).round(2)
  end
end
