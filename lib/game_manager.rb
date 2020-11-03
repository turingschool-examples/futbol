require 'csv'
require_relative './mathable'
require_relative './supportable'

class GameManager
  include Mathable
  include Supportable
  attr_reader :games
  def initialize(file_location)
    all(file_location)
  end

  def all(file_location)
    games_data = CSV.read(file_location, headers: true, header_converters: :symbol)
    @games = games_data.map { |game_data| Game.new(game_data) }
  end

  def highest_total_score
    @games.max_by { |game| game.total_score }.total_score
  end

  def lowest_total_score
    @games.min_by { |game| game.total_score }.total_score
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
    @games.each { |game| games_by_season[game.season] += 1 }
    games_by_season
  end

  def average_goals_per_game
    percentage(@games.sum { |game| game.total_score }, @games.size, 2)
  end

  def games_by_season(season)
    @games.select { |game| season == game.season }
  end

  def game_ids_by_season(season)
    games_by_season(season).map { |game| game.id }
  end

  def goal_count(season)
    games_by_season(season).sum { |game| game.total_score }
  end

  def average_goals_by_season
    avg_by_season = counter_hash
    count_of_games_by_season.each do |season, games|
      avg = percentage(goal_count(season), games, 2)
      avg_by_season[season] += avg
    end
    avg_by_season
  end

  def games_by_team(team_id)
    @games.select { |game| game.match?(team_id) }
  end

  def team_games_by_season(team_id)
    team_by_season = collector_hash
    games_by_team(team_id).each do |game|
      team_by_season[game.season] << game
    end
    team_by_season
  end

  def team_games_by_opponent(team_id)
    games = collector_hash
    games_by_team(team_id).each do |game|
      games[game.away_team_id] << game if !game.away?(team_id)
      games[game.home_team_id] << game if !game.home?(team_id)
    end
    games
  end

  def team_season_stats(team_id)
    game_stats_for(team_games_by_season(team_id), team_id)
  end

  def team_opponent_stats(team_id)
    game_stats_for(team_games_by_opponent(team_id), team_id)
  end

  def percentage_wins_by_season(team_id)
    percentage_wins_by(team_season_stats(team_id), team_id)
  end

  def percentage_wins_by_opponent(team_id)
    percentage_wins_by(team_opponent_stats(team_id), team_id)
  end

  def best_season(team_id)
    percentage_wins_by_season(team_id).max_by { |season, pct| pct }.first
  end

  def worst_season(team_id)
    percentage_wins_by_season(team_id).min_by { |season, pct| pct }.first
  end

  def average_win_percentage(team_id)
    total_games = 0
    total_wins = 0
    team_season_stats(team_id).each do |season, stats|
      total_games += stats[:game_count]
      total_wins += stats[:win_count]
    end
    percentage(total_wins, total_games, 2)
  end

  def most_goals_scored(team_id)
    away = games_by_team(team_id).max_by { |game| game.away_goals }
    home = games_by_team(team_id).max_by { |game| game.home_goals }
    return away.away_goals if away.away_goals > home.home_goals
    return home.home_goals if home.home_goals >= away.away_goals
  end

  def fewest_goals_scored(team_id)
    away = games_by_team(team_id).min_by { |game| game.away_goals }
    home = games_by_team(team_id).min_by { |game| game.home_goals }
    return away.away_goals if away.away_goals < home.home_goals
    return home.home_goals if home.home_goals <= away.away_goals
  end

  def favorite_opponent(team_id)
    percentage_wins_by_opponent(team_id).max_by { |opp, pct| pct }.first
  end

  def rival(team_id)
    percentage_wins_by_opponent(team_id).min_by { |opp, pct| pct }.first
  end
end
