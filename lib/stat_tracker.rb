require 'csv'

class StatTracker
  attr_reader :games_collection, :teams_collection, :game_teams_collection

  def initialize(games_collection, teams_collection)
    @games_collection = games_collection
    @teams_collection = teams_collection
    # @game_team = game_team
  end

  def average_goals_per_game
    sum = 0

    @games_collection.games.each do |game|
      sum += (game.away_goals.to_i + game.home_goals.to_i)
    end

    (sum.to_f / @games_collection.games.length).round(2)
  end

  def average_goals_by_season
    sums = {}
    averages = {}

    @games_collection.games.each do |game|
      if !sums.key?(game.season)
        sums[game.season] = (game.home_goals.to_i + game.away_goals.to_i)
      else
        sums[game.season] += (game.home_goals.to_i + game.away_goals.to_i)
      end
    end

    sums.each do |key, value|
      averages[key] = (value.to_f / count_of_games_by_season[key]).round(2)
    end

    averages
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
