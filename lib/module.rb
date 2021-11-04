module Averageable
  def average(amount,total)
    ((amount / total) * 100).ceil(2)
  end
end
