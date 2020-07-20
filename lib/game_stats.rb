class GameStats < Stats

  def unique_games
    @games.count
  end

  def highest_total_score
    @games.map do |game|
      game.away_goals + game.home_goals
    end.max
  end

  def lowest_total_score
    @games.map do |game|
      game.away_goals + game.home_goals
    end.min
  end

  def percentage_home_wins
    home_wins = @game_teams.find_all do |game|
      game.hoa == "home" && game.result == "WIN"
    end.count
    (home_wins / unique_games.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_teams.find_all do |game|
      game.hoa == "away" && game.result == "WIN"
    end.count
    (visitor_wins / unique_games.to_f).round(2)
  end

  def percentage_ties
    tie_games = @game_teams.find_all do |game|
      game.result == "TIE"
    end.count / 2
    (tie_games.to_f / unique_games).round(2)
  end

  def count_of_games_by_season
    grouped_by_season = @games.group_by do |game|
      game.season
    end
    grouped_by_season.each do |season, games|
      grouped_by_season[season] = games.count
    end
  end

  def average_goals_per_game
    gpg = @game_teams.sum do |game|
      game.goals.to_f
    end
    (gpg / unique_games).round(2)
  end

  def average_goals_by_season
    grouped_by_season = @games.group_by do |game|
      game.season
    end
    grouped_by_season.each do |season, games_array|
      goals = games_array.sum do |game|
        game.away_goals + game.home_goals
      end
      grouped_by_season[season] = (goals.to_f / games_array.count).round(2)
    end
  end
end
