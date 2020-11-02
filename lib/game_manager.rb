require 'csv'
require_relative './mathable'
require_relative './hashable'

class GameManager
  include Mathable
  include Hashable
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
    @games.max_by do |game|
      game.total_score
    end.total_score
  end

  def lowest_total_score
    @games.min_by do |game|
      game.total_score
    end.total_score
  end

  def percentage_home_wins
    percentage(@games.count { |game| game.home_win? }, @games.size, 2)
  end

  def percentage_visitor_wins
    percentage(@games.count { |game| game.visitor_win? }, @games.size, 2)
  end

  def percentage_ties
    percentage(@games.count { |game| game.tie? }, @games.size, 2)
  end

  def count_of_games_by_season
    games_by_season = counter_hash
    @games.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    percentage(@games.sum { |game| game.total_score }, @games.size, 2)
  end

  def games_by_season(season)
    @games.select do |game|
      season == game.season
    end
  end

  def game_ids_by_season(season)
    games_by_season(season).map do |game|
      game.id
    end
  end

  def goal_count(season)
    games_by_season(season).sum do |game|
      game.total_score
    end
  end

  def average_goals_by_season
    avg_by_season = counter_hash
    count_of_games_by_season.each do |season, games|
      avg = percentage(goal_count(season), games, 2)
      avg_by_season[season] += avg
    end
    avg_by_season
  end

  def games_by_team(id)
    @games.select do |game|
      game.match?(id)
    end
  end

  def team_games_by_season(id)
    team_by_season = collector_hash
    games_by_team(id).each do |game|
      team_by_season[game.season] << game
    end
    team_by_season
  end

  def team_games_by_opponent(id)
    games = collector_hash
    games_by_team(id).each do |game|
      games[game.away_team_id] << game if !game.away?(id)
      games[game.home_team_id] << game if !game.home?(id)
    end
    games
  end

  def team_season_stats(id)
    season_stats = counter_sub_hash
    team_games_by_season(id).each do |season, games|
      games.each do |game|
        season_stats[season][:game_count] += 1
        season_stats[season][:win_count] += 1 if game.win?(id)
      end
    end
    season_stats
  end

  def team_opponent_stats(id)
    opponent_stats = counter_sub_hash
    team_games_by_opponent(id).each do |opponent, games|
      games.each do |game|
        opponent_stats[opponent][:game_count] += 1
        opponent_stats[opponent][:win_count] += 1 if game.win?(id)
      end
    end
    opponent_stats
  end

  def percentage_wins_by_season(id)
    pct_hash = counter_hash
    team_season_stats(id).each do |season, stats|
      pct_hash[season] = percentage(stats[:win_count], stats[:game_count], 2)
    end
    pct_hash
  end

  def percentage_wins_by_opponent(id)
    pct_hash = counter_hash
    team_opponent_stats(id).each do |opponent, stats|
      pct_hash[opponent] = percentage(stats[:win_count], stats[:game_count], 2)
    end
    pct_hash
  end

  def best_season(id)
    percentage_wins_by_season(id).max_by do |season, percentage|
      percentage
    end.first
  end

  def worst_season(id)
    percentage_wins_by_season(id).min_by do |season, percentage|
      percentage
    end.first
  end

  def average_win_percentage(id)
    total_games = 0
    total_wins = 0
    team_season_stats(id).each do |season, stats|
      total_games += stats[:game_count]
      total_wins += stats[:win_count]
    end
    percentage(total_wins, total_games, 2)
  end

  def most_goals_scored(id)
    goals = 0
    games_by_team(id).each do |game|
      if game.away?(id)
        goals = game.away_goals if game.away_goals > goals
      else
        goals = game.home_goals if game.home_goals > goals
      end
    end
    goals
  end

  def fewest_goals_scored(id)
    goals = 99
    games_by_team(id).each do |game|
      if game.away?(id)
        goals = game.away_goals if game.away_goals < goals
      else
        goals = game.home_goals if game.home_goals < goals
      end
    end
    goals
  end

  def favorite_opponent(id)
    percentage_wins_by_opponent(id).max_by do |opponent, percentage|
      percentage
    end.first
  end

  def rival(id)
    percentage_wins_by_opponent(id).min_by do |opponent, percentage|
      percentage
    end.first
  end
end
