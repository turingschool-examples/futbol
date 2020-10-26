class GameStats
  attr_reader :stats

  def initialize(stats)
    @stats = stats
  end

  ############### DATA CONVERSION HELPER
  def convert_to_i(array)
    array.map(&:to_i)
  end

  ############### DATA CONVERSION HELPER
  def sum_data(data_key, data = @stats)
    convert_to_i(iterator(data_key, data)).sum
  end

  def iterator(header, data = @stats) # ask what it wants to convert to data type
    data.map do |stat|
      stat[header]
    end
  end

  def highest_total_score
    temp = []
    require "pry"; binding.pry
    temp << convert_to_i(iterator(:away_goals))
    temp << convert_to_i(iterator(:home_goals))
  end
  # [[home_goals],[away_goals]].transpose
  # [[1st_away, 1st_home],[2nd_away, 2nd_home]].reduce.sum


  ##########################################################
  # This method returns a table that has only the rows where the data_value is inside the header column#######
  # SUPER IMPORTANT METHOD ################
  # def team_stats(header, data_value)
  #   temp = @stats
  #   temp.delete_if do |row|
  #     row[header] != data_value
  #   end
  # end
end
