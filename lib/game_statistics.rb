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

  def combine_columns(header1, header2)
    temp = []
    temp << convert_to_i(iterator(header1))
    temp << convert_to_i(iterator(header2))
    temp = temp.transpose
    temp.map do |goals|
      goals.sum
    end
  end

  def highest_total_score
    combine_columns(:away_goals, :home_goals).max
  end

  def lowest_total_score
    combine_columns(:away_goals, :home_goals).min
  end

  def percentage_results(hoa, result)
    temp = []
    temp << iterator(:hoa)
    temp << iterator(:result)
    temp = temp.transpose

    outcomes = temp.count do |game_half|
      game_half.include?(hoa) && game_half.include?(result)
    end
    games = temp.count / 2
    (outcomes.to_f / games).round(2)
  end

  def percentage_home_wins
    percentage_results("home", "WIN")
  end

  def percentage_visitor_wins
    percentage_results("away", "WIN")
  end

  def percentage_ties
    percentage_results("home", "TIE")
  end

  def average_goals_per_game
    result = combine_columns(:away_goals, :home_goals).sum.to_f / iterator(:away_goals).length
    result.round(2)
  end

  def include_values(value)
    temp = iterator(:season)
    temp.count do |season|
      season == value
    end
  end

  def count_of_games_by_season
    hash = {}
    seasons = iterator(:season).uniq
    seasons.each do |season|
      hash[season] = include_values(season)
    end
    hash 
  end
end
