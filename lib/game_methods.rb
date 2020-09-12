# frozen_string_literal: true

require 'CSV'
require_relative './game'

# Holds methods that get data out of a CSV file
class GameMethods
  attr_reader :file_loc, :games, :home_goals, :away_goals

  def initialize(file_loc)
    @file_loc = file_loc
    @games = create_games
  end

  def create_games
    CSV.parse(File.read(@file_loc), headers: true).map do |row|
      Game.new(row)
    end
  end

  def highest_total_score
    game_totals = @games.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
    game_totals.max
  end

  def lowest_total_score
    game_totals = @games.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end

    game_totals.min
  end

  def average_goals_by_season
    output_hash = {}
    games_by_season.each do |season, games|
      output_hash[season] = (games.sum do |game|
        game.away_goals.to_i + game.home_goals.to_i
      end.to_f / games.length).round(2)
    end
    output_hash
  end

  def average_goals_per_game
    (@games.sum do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end.to_f / @games.length).round(2)
  end

  def games_by_season
    @games.group_by do |game|
      game.season
    end
  end

  def count_of_games_by_season
    output_hash = {}
    season_games = games_by_season
    season_games.keys.each do |season|
      output_hash[season] = season_games[season].length
    end
    output_hash
  end

  def determine_winner(game)
    if game.home_goals.to_i > game.away_goals.to_i
      :home
    elsif game.home_goals.to_i < game.away_goals.to_i
      :away
    else
      :tie
    end
  end

  def percentage_ties
    ties = @games.count do |game|
      :tie == determine_winner(game)
    end
    (ties.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    away_wins = @games.count do |game|
      :away == determine_winner(game)
    end
    (away_wins.to_f / @games.length).round(2)
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      :home == determine_winner(game)
    end
    (home_wins.to_f / @games.length).round(2)
  end
end
