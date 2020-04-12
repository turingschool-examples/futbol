# require './lib/stat_tracker'
require_relative './game'
require 'pry'


class GameStatistics
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

  def percentage_outcomes(outcome)
    if outcome == "home"
      games = @game_teams_collection.find_all do |game|
        game.home_or_away == "home"
      end
    elsif outcome == "away"
        games = @game_teams_collection.find_all do |game|
          game.home_or_away == "away"
        end
    elsif outcome == "tie"
        tied_games = @game_teams_collection.find_all do |game|
          game.result  == "TIE"
        end
      return ((tied_games.length.to_f/2) / (@game_teams_collection.length/2)).round(2)
    end
    won_games = games.find_all do |game|
        game.result  == "WIN"
      end
    (won_games.length.to_f / games.length).round(2)
  end



  # def percentage_home_wins
  #   home_games = @game_teams_collection.find_all do |game|
  #     game.home_or_away == "home"
  #   end
  #   won_home_games = home_games.find_all do |game|
  #     game.result  == "WIN"
  #   end
  #   (won_home_games.length.to_f / home_games.length) *100
  # end
  #
  # def percentage_visitor_wins
  #   home_games = @game_teams_collection.find_all do |game|
  #     game.home_or_away == "away"
  #   end
  #   won_home_games = home_games.find_all do |game|
  #     game.result  == "WIN"
  #   end
  #   (won_home_games.length.to_f / home_games.length) *100
  # end
  #
  # def percentage_ties
  #   tied_games = @game_teams_collection.find_all do |game|
  #   game.result  == "TIE"
  #   end
  #   (tied_games.length.to_f / (@game_teams_collection.length/2)) *100
  # end

  def count_of_games_by_season
    seasons = game_collection.group_by do |game|
      game.season
    end
    seasons.to_h do |key, value|
      [key, value.length]
    end
  end

  def average_goals(games)
    total_goals = games.map do |game|
      game.away_goals + game.home_goals
    end
    ave = (total_goals.sum / total_goals.length.to_f).round(2)
    ave
  end

  def average_goals_per_game
    average_goals(@game_collection)
  end

  def average_goals_by_season
    seasons = game_collection.group_by do |game|
    game.season
  end
  seasons.to_h do |key,value|
    [key, average_goals(value)]
    end
  end
end
