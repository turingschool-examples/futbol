require 'csv'
require_relative './mathable'

class GameManager
  include Mathable
  attr_reader :games,
              :tracker
  def initialize(path, tracker)
    @games = []
    create_underscore_games(path)
    @tracker = tracker
  end

  def create_underscore_games(path)
    games_data = CSV.read(path, headers: true)
    @games = games_data.map do |data|
      Game.new(data, self)
    end
  end

  def highest_total_score
    highest_score = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest_score.away_goals + highest_score.home_goals
  end

  def lowest_total_score
    lowest_score = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    lowest_score.away_goals + lowest_score.home_goals
  end

  def percentage_home_wins # game_manager.rb
    home_wins = @games.count do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.to_f / games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.to_f / games.length).round(2)
  end

  def percentage_ties
    tie_games = @games.count do |game|
      game.away_goals == game.home_goals
    end
    (tie_games.to_f / games.length).round(2)
  end

  def average_goals_by_season
    average_goals_season = Hash.new(0)
    games_by_season = count_of_games_by_season
    @games.each do |game|
      average_goals_season[game.season] += (game.home_goals + game.away_goals)
    end
    average_goals_season.map do |season, goals|
      [season, (goals.to_f / games_by_season[season].to_f).round(2)]
    end.to_h
  end

  def highest_scoring_visitor
    team_game_count = Hash.new(0)
    away_points = Hash.new(0)
    @games.each do |game|
      away_points[game.away_team_id] += game.away_goals
      team_game_count[game.away_team_id] += 1
    end
    highest_scoring_visitor = sort_percentages(away_points, team_game_count)
    @tracker.get_team_name(highest_scoring_visitor.last[0])
  end

  def highest_scoring_home_team
    team_game_count = Hash.new(0)
    home_points = Hash.new(0)
    @games.each do |game|
      home_points[game.home_team_id] += game.home_goals
      team_game_count[game.home_team_id] += 1
    end
    highest_scoring_home_team = sort_percentages(home_points, team_game_count)
    @tracker.get_team_name(highest_scoring_home_team.last[0])
  end

  def lowest_scoring_visitor
    team_game_count = Hash.new(0)
    away_points = Hash.new(0)
    @games.each do |game|
      away_points[game.away_team_id] += game.away_goals
      team_game_count[game.away_team_id] += 1
    end
    lowest_scoring_visitor = sort_percentages(away_points, team_game_count)
    @tracker.get_team_name(lowest_scoring_visitor.first[0])
  end

  def get_season_game_ids(season)
    games_in_season = @games.select do |game|
      game.season == season
    end
    games_in_season.map do |game|
      game.game_id
    end
  end

  def lowest_scoring_home_team
    team_game_count = Hash.new(0)
    home_points = Hash.new(0)
    @games.each do |game|
      home_points[game.home_team_id] += game.home_goals
      team_game_count[game.home_team_id] += 1
    end
    lowest_scoring_home_team = sort_percentages(home_points, team_game_count)
    @tracker.get_team_name(lowest_scoring_home_team.first[0])
  end


  def best_season(team_id)
    wins_by_season = Hash.new(0.0)
    games_by_season = Hash.new { |hash, key| hash[key] = [] }
    @games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        games_by_season[game.season] << game
      end
    end
    games_by_season.each do |season, games|
      games.each do |game|
        if game.home_team_id == team_id && game.home_goals > game.away_goals
          wins_by_season[season] += 1
        elsif game.away_team_id == team_id && game.away_goals > game.home_goals
          wins_by_season[season] += 1
        end
      end
    end
    games_by_season.max_by do |season, games|
      wins_by_season[season] / games.length
    end[0]
  end

  def worst_season(team_id)
    wins_by_season = Hash.new(0.0)
    games_by_season = Hash.new { |hash, key| hash[key] = [] }
    @games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        games_by_season[game.season] << game
      end
    end
    games_by_season.each do |season, games|
      games.each do |game|
        if game.home_team_id == team_id && game.home_goals > game.away_goals
          wins_by_season[season] += 1
        elsif game.away_team_id == team_id && game.away_goals > game.home_goals
          wins_by_season[season] += 1
        end
      end
    end
    games_by_season.min_by do |season, games|
      wins_by_season[season] / games.length
    end[0]
  end

  def winningest_coach(season)
    game_ids = get_season_game_ids(season)
    @tracker.find_winningest_coach(game_ids, "WIN")
  end

  def worst_coach(season)
    game_ids = get_season_game_ids(season)
    @tracker.find_worst_coach(game_ids)
  end

  def count_of_games_by_season
    @games.reduce(Hash.new(0)) do |collector, game|
      collector[game.season] += 1
      collector
    end
  end

  def average_goals_per_game
    average_goals = @games.sum do |game|
      game.home_goals + game.away_goals
    end
    (average_goals.to_f / games.length).round(2)
  end
end
