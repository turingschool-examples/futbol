require 'csv'

class GameStats
  def self.from_csv(locations)
    GameStats.new(locations)
  end

  def initialize(locations)
    @locations = locations #this is a hash
    @games_table = CSV.parse(File.read(@locations[:games]), headers: true)
  end

  def sum_of_scores
    @games_table.map do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
  end

  def highest_total_score
    sum_of_scores.max
  end

  def lowest_total_score
    sum_of_scores.min
  end

end
