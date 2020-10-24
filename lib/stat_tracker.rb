class StatTracker
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
  end

  def sum_of_scores
    #array of ints
    #(games.csv).map do |game|
      #home_team_scores + away_team_scores
    #end
  end

  def highest_total_score
    # sum_of_scores.max
  end

end
