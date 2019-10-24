module Game

  def highest_total_score
    result = games.max_by do |game|
      game.away_goals + game.home_goals
    end
    self.calculate_total_score(result)
  end

  def lowest_total_score
    result = games.min_by do |game|
      game.away_goals + game.home_goals
    end
    self.calculate_total_score(result)
  end

  def biggest_blowout
    games.max_by do |game|
      (game.away_goals - game.home_goals).abs
    end
  end

  def percentage_home_wins
    wins = games.count do |game|
      game.home_goals > game.away_goals
    end
    (wins.to_f / games.count).round(3) * 100
  end

  def percentage_visitor_wins
    wins = games.count do |game|
      game.home_goals < game.away_goals
    end
    (wins.to_f / games.count).round(3) * 100
  end

  def percentage_ties
    ties = games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties.to_f / games.count).round(3) * 100
  end

  def count_of_games_by_season
    hash = @games.reduce({}) do |acc, game|
      if acc[game.season]
        acc[game.season] += 1
      else
        acc[game.season] = 1
      end
      acc
    end
    hash
  end

  def average_goals_per_game
    average = @games.map {|game| self.calculate_total_score(game)}
    average.inject {|sum, num| sum + num} / games.length.to_f
  end

  def average_goals_by_season
    avg_goals = @games.group_by {|game| game.season}
    avg_goals.transform_values do |v|
      total = v.map {|game| self.calculate_total_score(game)}.inject {|sum, num| sum + num}
      total / v.length.to_f
    end
  end

  #HELPER METHODS

  def calculate_total_score(game)
    game.away_goals + game.home_goals
  end

  def generate_seasons_hash(games)
    avg_by_season = Hash.new
    seasons = games.map {|game| game.season}.uniq
    seasons.each {|season| avg_by_season[season] = 0}
  end


end
