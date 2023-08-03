module GameStatable

  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def total_games
    @games.count { |game| game }.to_f
  end

  def percentage_home_wins
    home_wins = @game_teams.count do |game|
      game.result == "WIN" && game.hoa == "home"
    end
    (home_wins / self.total_games).round(2).to_f
  end
  
  def percentage_visitor_wins
    visitor_wins = @game_teams.count do |game|
      game.result == "WIN" && game.hoa == "away"
    end
    (visitor_wins / self.total_games).round(2).to_f
  end

  def percentage_ties
    ties = @game_teams.count do |game|
      game.result == "TIE" && game.hoa == "away"
    end
    (ties / self.total_games).round(2).to_f
  end

  def average_goals_per_game
    total_goals = @games.map { |game| game.away_goals + game.home_goals }.sum.to_f
    (total_goals / @games.count).to_f.round(2)
  end

  def count_of_games_by_season
    @games.each_with_object(Hash.new(0)) { |game, game_count| game_count[game.season] += 1 }
  end
  
  def count_of_teams
    @teams.count
  end






  def count_of_games_by_season
    @games.each_with_object(Hash.new(0)) { |game, game_count| game_count[game.season] += 1 }
  end
 

  def total_goals_by_season
    total_goals_by_season = @games.each_with_object(Hash.new(0.0)) { |game, hash| hash[game.season] += game.away_goals + game.home_goals}
  end 

  def average_goals_by_season
    average_goals_by_season = Hash.new(0)
    total_goals_by_season.each do |key, value| 
      average_goals_by_season[key] = (value / count_of_games_by_season[key]).round(2)
    end
    average_goals_by_season
  end 
  
end