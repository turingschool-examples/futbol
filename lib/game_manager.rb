require 'csv'
require_relative './game'


class GameManager
  attr_reader :games_data_path,
              :games
  def initialize(file_location)
    @games_data = file_location
    @games = []
  end

  def all
    CSV.foreach(@games_data, headers: true, header_converters: :symbol) do |row|
      game_attributes = {
                          game_id: row[:game_id],
                          season: row[:season],
                          away_team_id: row[:away_team_id],
                          home_team_id: row[:home_team_id],
                          away_goals: row[:away_goals],
                          home_goals: row[:home_goals],
                        }
      @games << Game.new(game_attributes)
    end
    @games
  end

  def highest_total_score
    most_goals = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    most_goals.away_goals + most_goals.home_goals
  end

  def lowest_total_score
    least_goals = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    least_goals.away_goals + least_goals.home_goals
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game.away_goals < game.home_goals
    end
    (home_wins.to_f / @games.size).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.to_f / @games.size).round(2)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.away_goals == game.home_goals
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
      game.away_goals + game.home_goals
    end

    (sum.to_f / @games.size).round(2)
  end

  def goal_count(season)
    games_by_season = @games.select do |game|
      season == game.season
    end
    games_by_season.sum do |game|
      game.away_goals + game.home_goals
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
