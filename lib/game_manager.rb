require 'csv'

class GameManager
  attr_reader :games
  def initialize(file_location)
    all(file_location)
  end

  def all(file_location)
    games_data = CSV.read(file_location, headers: true, header_converters: :symbol)
    @games = games_data.map do |game_data|
      Game.new(game_data)
    end
  end

  def highest_total_score
    most_goals = @games.max_by do |game|
      game.total_score
    end
    most_goals.total_score
  end

  def lowest_total_score
    least_goals = @games.min_by do |game|
      game.total_score
    end
    least_goals.total_score
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game.home_win?
    end
    (home_wins.to_f / @games.size).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game.visitor_win?
    end
    (visitor_wins.to_f / @games.size).round(2)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.tie?
    end
    (ties.to_f / @games.size).round(2)
  end

  def game_count(season)
    @games.count do |game|
      game.season == season
    end
  end

  def count_of_games_by_season
    games_by_season = {}
    @games.each do |game|
      games_by_season[game.season] = game_count(game.season)
    end
    games_by_season
  end

  def average_goals_per_game
    sum = @games.sum do |game|
      game.total_score
    end

    (sum.to_f / @games.size).round(2)
  end

  def goal_count(season)
    games_by_season = @games.select do |game|
      season == game.season
    end
    games_by_season.sum do |game|
      game.total_score
    end
  end

  def average_goals_by_season
    avg_by_season = {}
    @games.each do |game|
      avg_by_season[game.season] = (goal_count(game.season) / game_count(game.season).to_f).round(2)
    end
    avg_by_season
  end
end
