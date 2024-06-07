class GameStats

  attr_reader :games

  def initialize(games)
    @games = games
  end

  def highest_total_score
    @games.map { |game| game.away_goals.to_i + game.home_goals.to_i }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals.to_i + game.home_goals.to_i }.min
  end

  def percentage_home_wins
    total_games = @games.length
    home_wins = @games.count { |game| game.home_goals.to_i > game.away_goals.to_i }
    (home_wins.to_f / total_games * 100).round(2)
  end

  def percentage_visitor_wins
    total_games = @games.length
    visitor_wins = @games.count { |game| game.away_goals.to_i > game.home_goals.to_i }
    (visitor_wins.to_f / total_games * 100).round(2)
  end

  def percentage_ties
    total_games = @games.length
    ties = @games.count { |game| game.away_goals.to_i == game.home_goals.to_i }
    (ties.to_f / total_games * 100).round(2)
  end

  def count_games_in_seasons(seasons = ["20122013", "20132014", "20142015"])
    season_games = {}
    seasons.each do |season|
      count = @games.count { |game| game.season == season }
      season_games[season] = count
    end
    season_games
  end

  def average_goals_per_game
    total_goals = @games.sum { |game| game.away_goals.to_i + game.home_goals.to_i }
    total_games = @games.length
    total_goals.to_f / total_games
  end

  def average_goals_per_season(seasons = ["20122013", "20132014", "20142015", "20152016", "20162017"])
    average_goals_per_season = {}
  
    seasons.each do |season|
      games_in_season = count_games_in_seasons([season])
      total_goals = @games.select { |game| game.season == season }.sum { |game| game.away_goals.to_i + game.home_goals.to_i }
      total_games = games_in_season[season]
      average_goals_per_season[season] = total_goals.to_f / total_games
    end
  
    average_goals_per_season
  end



  
  
  

  
  


end