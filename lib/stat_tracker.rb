require 'csv'

class StatTracker

  def initialize(game_collection, team_collection)
    @game_collection = game_collection
    @team_collection = team_collection
    # @game_team = game_team
  end

  def highest_total_score
    total_scores = @game_collection.games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = @game_collection.games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    total_scores.min
  end
end
