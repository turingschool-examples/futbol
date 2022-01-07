require './lib/stats.rb'

class Game
  # attr_reader :

  def initialize
    # require "pry"; binding.pry
    # super(games)
    # super(teams)
    # super(game_teams)
    # @home_goals = []
    # @away_goals = []
    # @season = []

  end

  def highest_total_score(games_data)
    game_with_max = games_data.max_by do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    return game_with_max[:away_goals].to_i + game_with_max[:home_goals].to_i
  end

  def lowest_total_score(games_data)
    game_with_min = games_data.min_by do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    return game_with_min[:away_goals].to_i + game_with_min[:home_goals].to_i
  end

  def percentage_home_wins(game_teams_data)
    home_wins = game_teams_data.count do |game|
      game[:hoa] == "home" && game[:result] == "WIN"
    end
    (home_wins.to_f / game_teams_data.count.to_f).round(2)
  end

  def percentage_visitor_wins(game_teams_data)
    visitor_wins = game_teams_data.count do |game|
      game[:hoa] == "away" && game[:result] == "WIN"
    end
    (visitor_wins.to_f / game_teams_data.count.to_f).round(2)
  end

  def percentage_ties(games_data)
    (tie(games_data).count.to_f / games_data.count * 100).round(3)
  end

  def tie(games_data)
    games_data.find_all do |game|
      game[:home_goals] == game[:away_goals]
    end
  end

  def count_of_games_by_season(games_data)
    new_hash = {}
    keys = games_data.map do |row|
      row[:season]
    end.flatten.uniq
    keys.each do |key|
      new_hash[key] = sum_of_games_in_season(key, games_data)
    end
    new_hash
  end

  def sum_of_games_in_season(season_number, games_data)
    season_games = games_data.select do |row|
      row[:season] == season_number
    end
    season_games.count
  end

  def average_goals_per_game(game_data)
    total_goals = game_data.sum do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.to_f/game_data.count
    total_goals.round(2)
  end

  def average_goals_by_season(game_data)
    h = Hash.new(0)
    count = Hash.new(0)
    games_data.each do |row|
      h[row[:season]] += row[:home_goals].to_f + row[:away_goals].to_f
      count[row[:season]] += 1
    end
    h.each do |key, val|
      h[key] = (val/count[key]).round(2)
    end
    h
  end
end
