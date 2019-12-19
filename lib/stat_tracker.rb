# frozen_string_literal: true
require 'csv'

class StatTracker
  attr_reader :games_collection, :teams_collection, :game_teams_collection

  def initialize(games, teams)
    @games_collection = games
    @teams_collection = teams
    # @game_team = game_team
  end

  def percentage_home_visitor_wins(game_type)
    total_wins = 0
    total_games = @games_collection.games.length

    @games_collection.games.each do |game|
      if game_type == :home
        if game.home_goals.to_i > game.away_goals.to_i
          total_wins += 1
        end
      elsif game_type == :visitor
        if game.home_goals.to_i < game.away_goals.to_i
          total_wins += 1
        end
      end
    end
    (total_wins / total_games.to_f).round(2)
  end

  def highest_lowest_total_score(highest_lowest)
    total_scores = []

    @games_collection.games.each do |game|
      total_scores << (game.home_goals.to_i + game.away_goals.to_i)
    end

    if highest_lowest == :highest
      total_scores.max
    elsif highest_lowest == :lowest
      total_scores.min
    end
  end
end
