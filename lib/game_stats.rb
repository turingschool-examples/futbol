module GameStats

  def lowest_total_score
    @games.map {|game| game.total_goals}.min
  end

  def highest_total_score
    @games.map {|game| game.total_goals}.max
  end

  def average_goals_per_game
    total_goals = @games.sum{ |game| game.total_goals }
    (total_goals.to_f / @games.length).round(2)
  end

  def percentage_home_wins
    home_wins = @games.count{ |game| game.winner == :home_team }
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    total_away_wins = @games.count do |game|
      game.winner == :away_team
    end
    (total_away_wins/@games.length.to_f).round(2)
  end

  def percentage_ties
    total_tie_games = @games.count{ |game| game.winner == :tie }
    (total_tie_games.to_f / @games.length).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)

    @games.each do |game|
      games_by_season[game.season.to_s] += 1
    end
    games_by_season
  end

  def average_goals_by_season
    average_goals_per_season = Hash.new(0)
    seasons = @seasons.values.each do |season|
      goals_in_season = 0
      season.games_in_season.each do |game|
        goals_in_season += game.total_goals
      end
      average_goals = (goals_in_season.to_f / season.games_in_season.length).round(2)
      average_goals_per_season[season.season_id.to_s] = average_goals
    end
    average_goals_per_season
  end

end
