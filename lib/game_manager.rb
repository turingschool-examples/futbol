require 'CSV'
require_relative './game'
require_relative './manager'
require_relative './mathable'

class GameManager < Manager
  include Mathable
  attr_reader :games

  def initialize(file_path)
    @file_path = file_path
    @games = load(@file_path, Game)
  end

  def total_goals_by_game(game)
    game.away_goals + game.home_goals
  end

  def highest_total_score
    max = @games.max_by do |game|
      total_goals_by_game(game)
    end
    total_goals_by_game(max)
  end

  def lowest_total_score
    min = @games.min_by do |game|
      total_goals_by_game(game)
    end
    total_goals_by_game(min)
  end

  def home_wins_count
    @games.count do |game|
      game.away_goals < game.home_goals
    end
  end

  def visitor_wins_count
    @games.count do |game|
      game.away_goals > game.home_goals
    end
  end

  def ties_count
    @games.count do |game|
      game.away_goals == game.home_goals
    end
  end

  def percentage_home_wins
    find_percent(home_wins_count, @games.count)
  end

  def percentage_visitor_wins
    find_percent(visitor_wins_count, @games.count)
  end

  def percentage_ties
    find_percent(ties_count, @games.count)
  end

  def count_of_games_by_season
    season_data = Hash.new(0)
    @games.each do |game|
      season_data[game.season] += 1
    end
    season_data
  end

  def total_goals
    @games.sum do |game|
      total_goals_by_game(game)
    end
  end

  def average_goals_per_game
    find_percent(total_goals, @games.count)
  end

  def games_and_goals_per_season
    data = Hash.new {|h, k| h[k] = {"games" => 0, "goals" => 0}}
    @games.each do |game|
      data[game.season]["games"] += 1
      data[game.season]["goals"] += total_goals_by_game(game)
    end
    data
  end

  def average_goals_per_season
    average_goals_per_season = {}
    games_and_goals_per_season.each do |season, data|
      average_goals_per_season[season] = find_percent(data["goals"], data["games"])
    end
    average_goals_per_season
  end

  def seasons
    @games.map do |game|
      game.season
    end.uniq
  end

  def game_ids_by_season(season_id)
    @games.map do |game|
      game.game_id if game.season == season_id
    end
  end

  def games_and_wins_by_team(team_id)
    games_and_wins = Hash.new {|h, k| h[k] = {total_games: 0, total_wins: 0}}
    @games.each do |game|
      if game.away_team_id == team_id
        if game.away_win?
          games_and_wins[game.season][:total_wins] += 1
        end
        games_and_wins[game.season][:total_games] += 1
      elsif game.home_team_id == team_id
        if game.home_win?
          games_and_wins[game.season][:total_wins] += 1
        end
        games_and_wins[game.season][:total_games] += 1
      end
    end
    games_and_wins
  end

  def best_season(team_id)
    games_and_wins_by_team(team_id).max_by do |season_id, g_and_w|
      find_percent(g_and_w[:total_wins], g_and_w[:total_games])
    end.first
  end

  def worst_season(team_id)
    games_and_wins_by_team(team_id).min_by do |season_id, g_and_w|
      find_percent(g_and_w[:total_wins], g_and_w[:total_games])
    end.first
  end
end
