require_relative '../lib/game'
require_relative '../lib/game_teams'

module GameStats
  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max # sort[-1]
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min # sort[0]
  end

  def percentage_home_wins
    ((@games.count { |game| game.home_goals > game.away_goals }) / @games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    ((@games.count { |game| game.home_goals < game.away_goals }) / @games.length.to_f).round(2)
  end

  def percentage_ties
    ((@games.count { |game| game.home_goals == game.away_goals }) / @games.length.to_f).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    @games.each do |game|
      if games_by_season[game.season].nil?
        games_by_season[game.season] = 1
      else
        games_by_season[game.season] += 1
      end
    end
    games_by_season
  end

  def average_goals_per_game
    (@games.flat_map { |game| game.home_goals + game.away_goals }.sum / @games.length.to_f).round(2)
  end

  def average_goals_by_season
    games_in_season = count_of_games_by_season
    average_goals = {}
    goals_by_season.each do |season, goals|
      average_goals[season] = (goals / games_in_season[season].to_f).round(2)
    end
    average_goals
  end

  def goals_by_season
    goals_in_season = {}
    @games.each do |game|
      if goals_in_season[game.season].nil?
        goals_in_season[game.season] = (game.home_goals + game.away_goals)
      else
        goals_in_season[game.season] += (game.home_goals + game.away_goals)
      end
    end
    goals_in_season
  end
end
