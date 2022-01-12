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
    average(result)
  end

  def count_of_games_by_season
    game_count = Hash.new(0)
    @games.each do |game|
      game_count[game.season] += 1
    end
    game_count
  end

  def average_goals_per_game
    result = @games.reduce(0) do |sum, game|
      sum += (game.home_goals + game.away_goals)
    end
    average(result)
  end

  def average_goals_by_season
    season_hash = @games.group_by do |game|
      game.season
    end
    average_goals_by_season = season_hash.each_pair do |season, games|
      goal_total = 0
      games.each do |game|
        goal_total += game.home_goals.to_f
        goal_total += game.away_goals.to_f
      end
      season_hash[season] = (goal_total.to_f / games.length).round(2)
    end
  end
end
