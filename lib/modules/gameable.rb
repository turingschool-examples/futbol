module Gameable

  def highest_total_score
    game = games.values.max_by do |game| 
      game.home_team[:goals] + game.away_team[:goals]
    end

    game.home_team[:goals] + game.away_team[:goals]
  end

  def lowest_total_score
    
  end

  def biggest_blowout

  end

  def percentage_home_wins

  end

  def percentage_visitor_wins

  end

  def percentage_ties

  end

  def count_of_games_by_season

  end

  def average_goals_per_game

  end

  def average_goals_by_season

  end
end
