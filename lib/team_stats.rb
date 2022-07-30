require_relative './game_stats'
require 'pry'

module TeamStats
  include GameStats
  
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def team_info(team_id)
    headers = @teams[0].headers.map!(&:to_s)
    Hash[headers.zip((@teams.find { |team| team[:team_id] == team_id }).field(0..-1))].reject { |k| k == 'stadium' }
  end

  def best_season(team_id)
    seasonal_winrates(team_id).max_by { |_k, v| v }[0]
  end

  def worst_season(team_id)
    seasonal_winrates(team_id).min_by { |_k, v| v }[0]
  end

  def average_win_percentage(team_id)
    (seasonal_winrates(team_id).values.reduce(:+) / count_of_games_by_season(team_id).count).round(2)
  end

  # Team helper method - returns hash of a given team's seasons & win rates
  def seasonal_winrates(team_id)
    season_wins = @games.reduce(Hash.new(0)) do |hash, game|
      (hash[game[:season]] += 1) if game[:home_team_id] == team_id && game[:home_goals] > game[:away_goals]
      (hash[game[:season]] += 1) if game[:away_team_id] == team_id && game[:home_goals] < game[:away_goals]
      hash
    end
    season_games = count_of_games_by_season(team_id)
    season_wins.each { |k, v| season_wins[k] = v / (season_games[k] * 2).to_f }
  end

  def most_goals_scored(team_id)
    @game_teams.find_all { |game| game[:team_id] == team_id }.max_by { |game| game[:goals] }[:goals].to_i
  end

  def fewest_goals_scored(team_id)
    @game_teams.find_all { |game| game[:team_id] == team_id }.min_by { |game| game[:goals] }[:goals].to_i
  end

  def favorite_opponent(team_id)
    @teams.find { |team| team[:team_id] == win_hash(team_id).max_by { |_k, v| v }[0] }[:team_name]
  end

  def rival(team_id)
    @teams.find { |team| team[:team_id] == win_hash(team_id).min_by { |_k, v| v }[0] }[:team_name]
  end

  def win_hash(team_id)
    game_against_counter = Hash.new(0)
    wins = @games.reduce(Hash.new(0)) do |hash, game|
      (hash[game[:away_team_id]] += 1) if game[:home_team_id] == team_id && game[:home_goals] > game[:away_goals]
      (hash[game[:home_team_id]] += 1) if game[:away_team_id] == team_id && game[:home_goals] < game[:away_goals]
      game_against_counter[game[:away_team_id]] += 1 if game[:home_team_id] == team_id
      game_against_counter[game[:home_team_id]] += 1 if game[:away_team_id] == team_id
      hash
    end
    wins.each { |k, v| wins[k] = v / game_against_counter[k].to_f }.sort_by { |k, _v| k.to_i }
  end
end
