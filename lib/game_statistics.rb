module GameStatistics
  def highest_total_score
    sum = 0
    @games.each do |game|
      new_sum = game.away_goals + game.home_goals
      sum = new_sum if new_sum > sum
    end
    sum
  end

  def lowest_total_score
    sum = 0
    @games.each do |game|
      new_sum = game.away_goals + game.home_goals
      sum = new_sum if new_sum <= sum
    end
    sum
  end

  def biggest_blowout
    sum = 0
    @games.each do |game|
      new_sum = (game.away_goals - game.home_goals).abs
      sum = new_sum if new_sum > sum
    end
    sum
  end

  def percentage_home_wins
    wins = 0
    home_games = 0
    @game_teams.each do |game|
      if game.hoa == "home" && game.result == "WIN"
        wins += 1
        home_games += 1
      elsif game.hoa == "home" && game.result == "LOSS"
        home_games += 1
      end
    end
    (wins / home_games).to_f.round(2)
    # require 'pry'; binding.pry
  end

  def percentage_ties
    (@games.find_all do |game|
      game.away_goals == game.home_goals
    end.length.to_f / @games.length).round(2)
  end

  def count_of_games_by_season
    total_games = Hash.new(0)
    @games.each do |game|
      if !total_games.has_key?(game.season)
        total_games[game.season] = 1
      else
        total_games[game.season] += 1
      end
    end
    total_games
  end

  def average_goals_per_game
    (@games.sum do |game|
      game.home_goals + game.away_goals
    end.to_f / @games.length).round(2) 
  end

end
