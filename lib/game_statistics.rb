# require './lib/stat_tracker'
require './lib/statistics'
require './lib/game'
require 'pry'


class GameStatistics
  attr_reader :stat_tracker, :game_collection

  def initialize(game_collection, game_teams_collection, teams_collection)

    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
    @teams_collection = teams_collection
  end

  def highest_total_score
    total = @game_collection.map do |game|
      game.away_goals + game.home_goals
    end
    total.max_by {|score| score}
  end

  def lowest_total_score
    total = @game_collection.map do |game|
      game.away_goals + game.home_goals
    end
    total.min_by {|score| score}
  end

  def percentage_home_wins
    home_games = @game_teams_collection.find_all do |game|
      game.home_or_away == "home"
    end
    won_home_games = home_games.find_all do |game|
      game.result  == "WIN"
    end
    (won_home_games.length.to_f / home_games.length) *100
  end

  def percentage_visitor_wins
    home_games = @game_teams_collection.find_all do |game|
      game.home_or_away == "away"
    end
    won_home_games = home_games.find_all do |game|
      game.result  == "WIN"
    end
    (won_home_games.length.to_f / home_games.length) *100
  end

  def percentage_ties
    tied_games = @game_teams_collection.find_all do |game|
    game.result  == "TIE"
    end
    (tied_games.length.to_f / (@game_teams_collection.length/2)) *100
  end

  def count_of_games_by_season
    seasons = game_collection.group_by do |game|
      game.season
      
    end
    seasons.each do |key, value|
      value.length
  end
end
