# frozen_string_literal: true
require 'csv'

class StatTracker
  attr_reader :games_collection, :teams_collection, :game_teams_collection

  def initialize(games, teams)
    @games_collection = games
    @teams_collection = teams
    # @game_team = game_team
  end

  def percentage_home_wins(team_id)
    home_wins = 0
    total_games = 0
    @games_collection.games.each do |game|
      if game.home_team_id == team_id
        total_games += 1

        if game.home_goals.to_i > game.away_goals.to_i
          home_wins += 1
        end
      end
    end
    (home_wins / total_games.to_f).round(2)
  end
end
