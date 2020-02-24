module GameStatistics

  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals}.min
  end

  def biggest_blowout
    @games.map { |game| (game.away_goals - game.home_goals).abs}.max
  end

  def find_all_seasons
    @games.map do |game|
      game.season
    end.uniq
  end

  def count_of_games_by_season
    seasons_and_games_count = {}
    find_all_seasons.each do |season|
      seasons_and_games_count[season.to_s] = @games.count do |game|
        game.season == season
      end
    end
    seasons_and_games_count
  end

  def average_goals_per_game
    all_goals = @games.sum do |game|
      game.away_goals + game.home_goals
    end
    (all_goals / @games.length.to_f).round(2)
  end

  def find_games_by_season(season)
    @games.find_all do |game|
      game.season == season
    end
  end

  def average_goals_by_season
    seasons_and_goals_average = {}
    find_all_seasons.each do |season|
      sum_of_goals = find_games_by_season(season).sum do |game|
        (game.away_goals + game.home_goals)
      end
      seasons_and_goals_average[season.to_s] = (sum_of_goals.to_f / count_of_games_by_season[season.to_s]).round(2)
    end
    seasons_and_goals_average
  end

  def percentage_home_wins
    all_home_games = @game_teams.find_all do |game_team|
      game_team.hoa == "home"
    end
    home_wins = all_home_games.find_all do |game_team|
       game_team.result == "WIN"
    end
    (home_wins.length / all_home_games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    all_visitor_games = @game_teams.find_all do |game_team|
      game_team.hoa == "away"
    end
    visitor_wins = all_visitor_games.find_all do |game_team|
       game_team.result == "WIN"
    end
    (visitor_wins.length / all_visitor_games.length.to_f).round(2)
  end

  def percentage_ties
  all_ties = @game_teams.find_all do |game_team|
       game_team.result == "TIE"
    end
    (all_ties.length / @game_teams.length.to_f).round(2)
  end

end
