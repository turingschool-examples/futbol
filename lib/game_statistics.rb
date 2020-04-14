require_relative './game'
require_relative './mathable'
require 'pry'

class GameStatistics
  include Mathable

  attr_reader :stat_tracker, :game_collection

  def initialize(game_collection, game_teams_collection, teams_collection)

    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
    @teams_collection = teams_collection
  end

  def total_score(high_low)
    total = @game_collection.map do |game|
      game.away_goals + game.home_goals
    end
      if high_low == "high"
        total.max_by {|score| score}
      elsif high_low == "low"
      total.min_by {|score| score}
      end
  end

  def home_away_or_tie(home_or_away)
    if home_or_away == "home" || home_or_away == "away"
      @game_teams_collection.find_all do |game|
       game.home_or_away == home_or_away
     end
    else
      @game_teams_collection.find_all do |game|
        game.result  == "TIE"
      end
    end
  end

  def games_percent_calculation(games, outcome)
    if outcome == "TIE"
      ((games.length.to_f/2) / (@game_teams_collection.length/2)).round(2)
    else
      won_games = games.find_all do |game|
        game.result  == "WIN"
      end
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
    game_collection.group_by do |game|
      game.season
    end
  end

  def count_of_games_by_season
    seasons = group_by_season
      seasons.transform_values do |value|
         value.length
      end
  end

  def average_goals(games)
    total_goals = games.map do |game|
      game.away_goals + game.home_goals
    end
    average(total_goals.sum, total_goals.length.to_f)
  end

  def average_goals_per_game
    average_goals(@game_collection)
  end

  def average_goals_by_season
    seasons = group_by_season
      seasons.transform_values do |value|
        average_goals(value)
    end
  end
end
