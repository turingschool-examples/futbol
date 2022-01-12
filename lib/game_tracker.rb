require './lib/data_collector'
require './lib/calculator'

class GameTracker < Statistics
  include DataCollector
  include Calculator

  def total_score
    @games.reduce([]) do |array, game|
      array << game.away_goals + game.home_goals
      array
    end
  end

  def percentage_wins(home_away_tie)
    result = @games.count do |game|
      home_away_or_tie(game, home_away_tie)
    end
    average(result, @games)
  end

  def count_of_games_by_season
    game_count = Hash.new(0)
    @games.each do |game|
      game_count[game.season] += 1
    end
    game_count
  end

  def average_goals_per_game
    goals_per_game = @games.reduce(0) do |sum, game|
      sum += (game.home_goals + game.away_goals)
    end
    average(goals_per_game, @games)
  end

  def average_goals_by_season
    goals_by_season_hash = games_by_season_hash.reduce({}) do |hash, games_per_season|
      goals = games_per_season[1].sum {|game| game.home_goals + game.away_goals}
      hash[games_per_season[0]] = average(goals, games_per_season[1].length )
      hash
    end
    goals_by_season_hash
  end
end
