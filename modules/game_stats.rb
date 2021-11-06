module GameStats

  def highest_total_score
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    scores.max
  end

  def lowest_total_score
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    scores.min
  end

  #need home team id, hometeamwin.count / num of games
  def percentage_home_wins
   home_winners = creator.games_hash.values.find_all do |games|
        games.home_team_stat.result == "WIN"
    end
    home_winners.count.to_f / creator.games_hash.count.to_f.round(2)
  end

  def percentage_visitor_wins
    visitor_winners = creator.games_hash.values.find_all do |games|
         games.away_team_stat.result == "WIN"
    end
    visitor_winners.count.to_f / creator.games_hash.count.to_f.round(2)
  end

  def percentage_ties
    ties = creator.stats_hash.values.find_all do |games|
      games.result == "TIE"
    end
    ties.count / creator.games_hash.count.to_f.round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    creator.seasons_hash.each do |games|
        games_by_season[games[0]] = creator.games_hash.count
      end
    games_by_season
  end

  def average_goals_per_game
    #Average number of goals scored in a game across all seasons including both
    #home and away goals (rounded to the nearest 100th)
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    scores.sum / creator.games_hash.count.to_f.round(3)
  end

  def average_goals_by_season
    seasons_average_goals = {}
    creator.seasons_hash.each do |games|
        seasons_average_goals[games[0]] = average_goals_per_game
      end
    seasons_average_goals
  end

  end

