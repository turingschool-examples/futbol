module Gameable

  def highest_total_score
    game = games.values.max_by do |game|
      game.total_goals
    end

    game.total_goals
  end

  def lowest_total_score
    game = games.values.min_by do |game|
      game.total_goals
    end

    game.total_goals
  end

  def biggest_blowout
    game = games.values.max_by do |game|
      game.goals_difference.abs
    end
    game.goals_difference.abs
  end

  def percentage_home_wins
    num_home_wins = games.values.sum do |game|
      game.home_team[:goals] > game.away_team[:goals] ? 1 : 0 
    end
    (num_home_wins / games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    num_visitor_wins = games.values.sum do |game|
      game.away_team[:goals] > game.home_team[:goals] ? 1 : 0
    end
    (num_visitor_wins / games.length.to_f).round(2)
  end

  def percentage_ties
    num_ties = games.values.sum do |game|
      game.home_team[:goals] == game.away_team[:goals] ? 1 : 0
    end
    (num_ties / games.length.to_f).round(2)
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
    goals = games.values.sum do |game|
      game.total_goals
    end
    (goals / games.length.to_f).round(2)
  end

  def average_goals_by_season
    season_hash = {}
    seasons.each do |season_id, season|
      total_goals = 0
      season.teams.values.each do |team|
        total_goals += team.games.values.sum(&:total_goals)
      end
      game_count = season.teams.values.sum { |team| team.games.length }
      season_hash[season_id] = (total_goals / game_count.to_f).round(2)
    end
    season_hash
  end
end
