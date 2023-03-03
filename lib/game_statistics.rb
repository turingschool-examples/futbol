require_relative 'stats'

class GameStatistics < Stats
  def initialize(locations)
    super
  end

  def percentage_home_wins
    home_wins = 0
    @games.each do |game|
      home_wins += 1 if game.home_goals > game.away_goals
    end
    (home_wins.to_f / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @games.each do |game|
      visitor_wins += 1 if game.home_goals < game.away_goals
    end
    (visitor_wins.to_f / @games.count.to_f).round(2)
  end

  def percentage_ties
    ties = 0
    @games.each do |game|
      ties += 1 if game.home_goals == game.away_goals
    end
    percentage = (ties.to_f / @games.count.to_f).round(2)
  end

  def highest_total_score
    highest_score = sorted_scores.last
    highest_score

    # iterate over each game
    # summate home_goals & away_goals
    # shovel sum into array of sums
    # sort array
    # return the last element which will be the highest total score 
  end

  def lowest_total_score
    lowest_score = sorted_scores.first
    lowest_score

    # iterate over each game
    # summate home_goals & away_goals
    # shovel sum into array of sums
    # sort array
    # return the first element which will be the lowest total score 
  end

# helper method
  def sorted_scores
    scores = []
    @games.each do |game|
      sum_of_goals = game.home_goals + game.away_goals
      scores << sum_of_goals
    end
    scores.sort!
    scores
  end
end