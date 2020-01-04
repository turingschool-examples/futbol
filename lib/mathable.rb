require 'csv'

module Mathable

  def average(array_of_data, total_number)
    # sum = array_of_data.sum do |data|
    #   (data.away_goals + data.home_goals)
    # end

    (sum / total_number.to_f).round(2)
  end
end
