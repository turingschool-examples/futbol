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



  def count_of_games_by_season
    count = Hash.new(0)

    @games.each do |game|
      count[game.season] += 1
    end

    count
  end

end
