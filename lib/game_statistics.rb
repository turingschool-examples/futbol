require_relative './game'
require_relative './mathable'
require_relative './statistics'
require 'pry'

class GameStatistics < Statistics
  include Mathable

  def total_score(high_low)
    total = @game_collection.map {|game| game.away_goals + game.home_goals}
      if high_low == :high
        total.max_by {|score| score}
      elsif high_low == :low
        total.min_by {|score| score}
      end
  end

  def home_away_or_tie(home_or_away)
    if home_or_away == "home" || home_or_away == "away"
      @game_teams_collection.find_all {|game| game.home_or_away == home_or_away}
    else
      @game_teams_collection.find_all {|game| game.result  == "TIE"}
    end
  end

  def games_percent_calculation(games, outcome)
    if outcome == "TIE"
        ((games.length.to_f/2) / (@game_teams_collection.length/2)).round(2)
    else
      won_games = games.find_all {|game| game.result  == "WIN"}
        (won_games.length.to_f / games.length).round(2)
    end
  end

  def percentage_outcomes(outcome)
    if outcome == "home"
      games = home_away_or_tie("home")
        return games_percent_calculation(games, "home")
    elsif outcome == "away"
      games = home_away_or_tie("away")
        return games_percent_calculation(games, "away")
    elsif outcome == "tie"
      tied_games = home_away_or_tie("TIE")
        return games_percent_calculation(tied_games, "TIE")
    end
  end

  def group_by_season
    @game_collection.group_by {|game| game.season}
  end

  def count_of_games_by_season
    seasons = group_by_season
      seasons.transform_values {|value| value.length}
  end

  def average_goals(games)
    total_goals = games.map {|game| game.away_goals + game.home_goals}
      average(total_goals.sum, total_goals.length.to_f)
  end

  def average_goals_per_game
    average_goals(@game_collection)
  end

  def average_goals_by_season
    seasons = group_by_season
      seasons.transform_values {|value| average_goals(value)}
  end
end
