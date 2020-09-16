module Averageable

  def average_with_count(top, bottom, round = 4)
    (top / bottom.count).round(round)
  end

  def average(top, bottom, round = 4)
    (top / bottom).round(round)
  end
end
