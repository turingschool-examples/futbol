require 'csv'

class StatTracker
  attr_reader :games_collection, :teams_collection, :game_teams_collection

  def initialize(games_collection, teams_collection)
    @games_collection = games_collection
    @teams_collection = teams_collection
    # @game_team = game_team
  end

  def highest_total_score
    total_scores = @games_collection.games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = @games_collection.games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    total_scores.min
  end
end
