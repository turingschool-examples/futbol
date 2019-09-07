module GameStats

  def highest_total_score
    game = @games.max_by do |id, object|
      object.away_goals + object.home_goals
    end
    game[1].away_goals + game[1].home_goals
  end

  def lowest_total_score
    game = @games.min_by do |id, object|
      object.away_goals + object.home_goals
    end
    game[1].away_goals + game[1].home_goals
  end

  def biggest_blowout
    game = @games.max_by do |id, object|
      (object.away_goals - object.home_goals).abs
    end
    (game[1].away_goals - game[1].home_goals).abs
  end

  def percentage_home_wins
    (@games.count do |id, object|
      object.home_goals > object.away_goals
    end/@games.length.to_f * 100).round(2)
  end

  def percentage_visitor_wins
    (@games.count do |id, object|
      object.away_goals > object.home_goals
    end/@games.length.to_f * 100).round(2)
  end

  def percentage_ties
    (@games.count do |id, object|
      object.home_goals == object.away_goals
    end/@games.length.to_f * 100).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    @games.each do |id, object|
      games_by_season[object.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    (@games.inject(0) {|sum, (id, object)| sum += (object.home_goals + object.away_goals)} / @games.length.to_f).round(2)
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    @games.each do |id, object|
      goals_by_season[object.season] += (object.away_goals + object.home_goals)
    end
    goals_by_season.each do |season, goals|
      goals_by_season[season] = (goals / count_of_games_by_season[season].to_f).round(2)
    end
  end
end
