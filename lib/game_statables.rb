module GameStatables
  
  def all_home_wins
    home_wins = []
    @games.each do |game|
      home_wins << game if game.home_goals.to_i > game.away_goals.to_i
    end
    home_wins
  end

  def all_away_wins
    away_wins = []
    @games.each do |game|
      away_wins << game if game.away_goals.to_i > game.home_goals.to_i
    end
    away_wins
  end

  def all_ties
    tie_game = []
    @games.each do |game|
      tie_game << game if game.away_goals.to_i == game.home_goals.to_i
    end
    tie_game
  end

  def goals_by_season
    season_goals = Hash.new(0)
    @games.each do |game|
      season_goals[game.season_year] += game.total_score
    end
    season_goals
  end
end
