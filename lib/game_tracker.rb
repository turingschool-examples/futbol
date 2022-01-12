require './lib/data_collector'

class GameTracker < Statistics
  include DataCollector

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
    (result.to_f / @games.length).round(2)
  end

  # def percentage_ties
  #   total_games = 0
  #   ties = 0
  #   @games.each do |game|
  #     total_games += 1
  #     game.home_goals.to_i == game.away_goals.to_i ? ties += 1 : next
  #   end
  #   (ties.to_f / total_games).round(2)
  # end

  def count_of_games_by_season
    game_count = Hash.new(0)
    @games.each do |game|
      game_count[game.season] += 1
    end
    game_count
  end

  def average_goals_per_game
    total_games = 0
    total_scores = 0
    @games.each do |game|
      total_games += 1
      total_scores += (game.home_goals.to_i + game.away_goals.to_i)
    end
    (total_scores.to_f / total_games).round(2)
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
