require 'CSV'
require_relative './game'
require_relative './manager'

class GameManager < Manager
  attr_reader :games

  def initialize(file_path)
    @file_path = file_path
    @games = load(@file_path, Game)
  end

  def highest_total_score
    max = 0
    @games.each do |game|
      current = game.away_goals.to_i + game.home_goals.to_i
      max = current if current > max
    end
    max
  end

  def lowest_total_score
    min = 100000
    @games.each do |game|
      current = game.away_goals.to_i + game.home_goals.to_i
      min = current if current < min
    end
    min
  end

  def percentage_home_wins
    home_wins = 0
    @games.each do |game|
      if game.away_goals.to_i < game.home_goals.to_i
        home_wins += 1
      end
    end
    (home_wins.fdiv(@games.length.to_f)).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @games.each do |game|
      if game.away_goals.to_i > game.home_goals.to_i
        visitor_wins += 1
      end
    end
    (visitor_wins.fdiv(@games.length.to_f)).round(2)
  end

  def percentage_ties
    ties = 0
    @games.each do |game|
      if game.away_goals.to_i == game.home_goals.to_i
        ties += 1
      end
    end
    (ties.fdiv(@games.length)).round(2)
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
    fill_season_data(season_data)
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

  def fill_season_data(season_data)
    seasons.each do |season|
      season_data[season]
    end
  end

  def worst_season(team_id)
    season_data = Hash.new {|h, k| h[k] = {total_games: 0, total_wins: 0}}
    fill_season_data(season_data)
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
