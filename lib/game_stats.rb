require_relative 'stat_data'

class GameStats < StatData

  def initialize(locations)
    super(locations)
  end

  def games_by_season
    seasons = Hash.new([])
    all_games.each do |game|
      seasons[game.season] = []
    end
    seasons.each do |season, games_array|
      all_games.each do |game|
        games_array << game if game.season == season
      end
    end
    seasons
  end

  def highest_total_score
   all_games.map do |game|
      game.total_score
    end.max
  end

  def lowest_total_score
    all_games.map do |game|
      game.total_score
    end.min
  end

  def percentage_home_wins
    team_wins = all_game_teams.select do |team|
      team.result == 'WIN' && team.home_or_away == 'home'
    end
    home_games = all_game_teams.select do |game|
      game.home_or_away == 'home'
    end
    (team_wins.count / home_games.count.to_f).round(2)
  end
  
  def percentage_visitor_wins
    team_wins = all_game_teams.select do |team|
      team.result == 'WIN' && team.home_or_away == 'away'
    end
    away_games = all_game_teams.select do |game|
      game.home_or_away == 'away'
    end
    (team_wins.count / away_games.count.to_f).round(2)
  end
    
  def percentage_ties
    (1.0 - percentage_home_wins - percentage_visitor_wins).round(2)
  end

  def count_of_games_by_season
    games_by_season.transform_values{|value| value.count} 
  end

  def average_goals_by_season
    games_by_season.transform_values do |games_array|
      scores_array = games_array.map(&:total_score)
      (scores_array.sum.to_f / scores_array.length).round(2)
    end
  end
end
