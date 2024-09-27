module SuccessRate
  def highest_success_rate(data)
    data.max_by { |team,percentage| percentage }
  end
  
  def lowest_success_rate(data)
    data.min_by { |team,percentage| percentage }
  end
end