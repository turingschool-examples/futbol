module GameStats

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
  
  def average_goals_by_season
    average_goals_per_season = Hash.new(0)
    seasons = @games[:season].uniq
    seasons.each do |season|
      total_goals_in_season = 0
      total_games_in_season = 0
      @games.each do |game|
        if game[:season] == season
          total_goals_in_season += game[:away_goals] + game[:home_goals]
          total_games_in_season += 1
        end
      end
      average_goals_per_season[season] = total_goals_in_season.to_f / total_games_in_season
    end
    average_goals_per_season

  def percentage_ties
    total_tie_games = @games.count{ |game| game.winner == :tie }
    (total_tie_games.to_f / @games.length).round(2)
  end
end
