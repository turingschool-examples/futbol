require_relative "./stat_tracker"
require_relative "./stat_helper"
class GameStatistics < StatHelper

  def initialize(files)
    super
  end

  def scores
    scores = @games.map { |game| (game.away_goals + game.home_goals)}
  end

  def highest_total_score
    scores.max
  end

  def lowest_total_score
    scores.min
  end

  def percentage_home_wins
    home_wins = 0
    @game_teams.find_all do |row|
      !home_wins += 1 if row.hoa == "home" && row.result == "WIN" || 
                          row.hoa == "away" && row.result == "LOSS"
    end
    (home_wins / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @game_teams.find_all do |row|
      visitor_wins += 1 if row.hoa == "away" && row.result == "WIN" || 
                           row.hoa == "home" && row.result == "LOSS"
    end
    (visitor_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_ties
    no_lose = 0
    @game_teams.find_all do |row|
      no_lose += 1 if row.hoa == "home" && row.result == "TIE" || 
                      row.hoa == "away" && row.result == "TIE"
    end
    (no_lose.to_f / @game_teams.count.to_f).round(2)
  end

  def count_of_games_by_season
    season_games_count = {}
    @games.each do |game|
      if season_games_count.keys.include?(game.season)
        season_games_count[game.season] += 1
      else
        season_games_count[game.season] = 1
      end
    end
    season_games_count
  end
  
  def average_goals_per_game
    total_goals = games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    (total_goals.sum / games.length.to_f).round(2)
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    games.each do |game|
      season = game.season
      total_goals = game.away_goals + game.home_goals
      goals_by_season[season] += total_goals
    end
    average_goals = {}
    goals_by_season.each do |season, total_goals|
      games_played = count_of_games_by_season[season]
      average_goals[season] = (total_goals.to_f / games_played).round(2)
    end
    average_goals
  end
end
