module GameStats

  def highest_total_score
    highest_game = @games.max_by do |game|
      game.away_goals + game.home_goals
    end

    highest_game.away_goals + highest_game.home_goals
  end

  def lowest_total_score
    lowest_game = @games.min_by do |game|
      game.away_goals + game.home_goals
    end

    lowest_game.away_goals + lowest_game.home_goals
  end

  def biggest_blowout
    blowout_game = @games.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end
    (blowout_game.home_goals - blowout_game.away_goals).abs
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game.home_goals > game.away_goals
    end
    (home_wins / @games.length.to_f * 100).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game.away_goals > game.home_goals
    end

    (visitor_wins / @games.length.to_f * 100).round(2)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.away_goals ==  game.home_goals
    end

    (ties / @games.length.to_f * 100).round(2)
  end

  def count_of_games_by_season
    count = Hash.new(0)

    @games.each do |game|
      count[game.season] += 1
    end

    count
  end


end
