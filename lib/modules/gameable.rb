module Gameable

  def highest_total_score
    game = games.values.max_by do |game|
      game.home_team[:goals] + game.away_team[:goals]
    end

    game.home_team[:goals] + game.away_team[:goals]
  end

  def lowest_total_score
    game = games.values.min_by do |game|
      game.home_team[:goals] + game.away_team[:goals]
    end

    game.home_team[:goals] + game.away_team[:goals]
  end

  def biggest_blowout
    game = games.values.max_by do |game|
      (game.home_team[:goals] - game.away_team[:goals]).abs
    end
    (game.home_team[:goals] - game.away_team[:goals]).abs
  end

  def percentage_home_wins
    num_home_wins = 0
    games.values.each do |game|
      if game.home_team[:goals] > game.away_team[:goals]
        num_home_wins += 1
      end
    end
    (num_home_wins / games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    num_visitor_wins = 0
    games.values.each do |game|
      if game.away_team[:goals] > game.home_team[:goals]
        num_visitor_wins += 1
      end
    end
    (num_visitor_wins / games.count.to_f).round(2)
  end

  def percentage_ties
    num_ties = 0
    games.values.each do |game|
      if game.home_team[:goals] == game.away_team[:goals]
        num_ties += 1
      end
    end
    (num_ties / games.count.to_f).round(2)
  end

  def count_of_games_by_season
    season_hash = {}
    seasons.each do |season_id, season|
      season_hash[season_id] = season.teams.values.sum {|team| team.games.count}
    end
    season_hash.each do |key, value|
      season_hash[key] = value / 2
    end
  end

  def average_goals_per_game
    goals = games.values.map do |game|
      game.home_team[:goals] + game.away_team[:goals]
    end
    ((goals.inject(0){|sum,x|sum + x}).to_f/games.count.to_f).round(2)
  end

  def average_goals_by_season
    season_hash = {}
    seasons.each do |season_id, season|
      total_goals = 0
      season.teams.values.each do |team|
        total_goals += team.games.values.sum do |game|
          game.home_team[:goals] + game.away_team[:goals]
        end
      end
      game_count = season.teams.values.sum {|team| team.games.count}
      season_hash[season_id] = (total_goals / game_count.to_f).round(2)
    end
    season_hash
  end
end
