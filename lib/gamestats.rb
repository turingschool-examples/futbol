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
      require 'pry'; binding.pry
      game[6] + game[7]
    end
  end

  def highest_total_score
    # sum_of_scores.max
  end

end
