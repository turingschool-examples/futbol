require 'csv'

class StatTracker
  attr_reader :game_collection, :team_collection, :game_teams

  def initialize(games, teams)
    @game_collection = games
    @team_collection = teams
    # @game_team = game_team
  end

  def average_goals_per_game
    sum = 0

    @game_collection.games.each do |game|
      sum += (game.away_goals.to_i + game.home_goals.to_i)
    end

    (sum.to_f / @game_collection.games.length).round(2)
  end

  def average_goals_by_season
    sums = {}
    averages = {}

    @game_collection.games.each do |game|
      if !sums.key?(game.season.to_i)
        sums[game.season.to_i] = (game.home_goals.to_i + game.away_goals.to_i)
      else
        sums[game.season.to_i] += (game.home_goals.to_i + game.away_goals.to_i)
      end
    end

    sums.each do |key, value|
      averages[key] = (value.to_f / count_of_games_by_season[key]).round(2)
    end

    averages
  end
end
