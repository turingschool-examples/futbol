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

  def total_goals(game)
    game.away_goals + game.home_goals
  end

  def highest_total_score
    max = @games.max_by do |game|
      total_goals(game)
    end
    total_goals(max)
  end

  def lowest_total_score
    min = @games.min_by do |game|
      total_goals(game)
    end
    total_goals(min)
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

  def average_goals_per_game
    goals = 0
    @games.each do |game|
      goals += (game.away_goals.to_i + game.home_goals.to_i)
    end
    (goals.fdiv(@games.length)).round(2)
  end

  def average_goals_per_season
    season_data = Hash.new { |hash, key| hash[key] = { "games" => 0, "goals" => 0} }
    @games.each do |game|
      season_data[game.season]["games"] += 1
      season_data[game.season]["goals"] += (game.away_goals.to_i + game.home_goals.to_i)
    end

    result = {}
    season_data.each do |season, data|
      result[season] = (data["goals"].fdiv(data["games"])).round(2)
    end
    result
  end

  def seasons
    @games.map do |game|
      game.season
    end.uniq
  end

  def game_ids_by_season(season_id)
    game_ids = []
    @games.each do |game|
      game_ids << game.game_id if game.season == season_id
    end
    game_ids
  end

  def best_season(team_id)
    season_data = Hash.new {|h, k| h[k] = {total_games: 0, total_wins: 0}}
    @games.each do |game|
      if game.away_team_id == team_id
        if game.away_win?
          season_data[game.season][:total_wins] += 1
        end
        season_data[game.season][:total_games] += 1
      elsif game.home_team_id == team_id
        if game.home_win?
          season_data[game.season][:total_wins] += 1
        end
        season_data[game.season][:total_games] += 1
      end
    end
    season_data.max_by do |season_id, season_data|
      season_data[:total_wins].fdiv(season_data[:total_games])
    end.first
  end

  def worst_season(team_id)
    season_data = Hash.new {|h, k| h[k] = {total_games: 0, total_wins: 0}}
    @games.each do |game|
      if game.away_team_id == team_id
        if game.away_win?
          season_data[game.season][:total_wins] += 1
        end
        season_data[game.season][:total_games] += 1
      elsif game.home_team_id == team_id
        if game.home_win?
          season_data[game.season][:total_wins] += 1
        end
        season_data[game.season][:total_games] += 1
      end
    end
    season_data.min_by do |season_id, season_data|
      season_data[:total_wins].fdiv(season_data[:total_games])
    end.first
  end
end
