require_relative 'game'
require 'csv'

class GamesCollection
  attr_reader :games

  def initialize(games_path)
    @games = generate_objects_from_csv(games_path)
  end

  def generate_objects_from_csv(csv_games_path)
    objects = []
    CSV.foreach(csv_games_path, headers: true, header_converters: :symbol) do |row_object|
      objects << Game.new(row_object)
    end
    objects
  end

  def number_of_games_in_each_season
    seasons_of_games = @games.group_by {|game| game.season}
    seasons_of_games.values.map {|value| value.length}
  end

  def count_of_games_by_season
    target_hash = {}
    unique_seasons.each_with_index do |season, index|
      target_hash[season] = number_of_games_in_each_season[index]
    end
    target_hash
  end

  def highest_total_score
    @games.map {|game| game.away_goals.to_i + game.home_goals.to_i }.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals.to_i + game.home_goals.to_i }.min
  end

  # Helper method designed to be reusable; consider moving to a module
  def every(attribute, collection)
    collection.map { |element| element.send(attribute) }
  end

  # Helper method designed to be reusable; consider moving to a module
  def every_unique(attribute, collection)
    every(attribute, collection).uniq
  end

  # Helper method designed to be reusable; consider moving to a module
  def total_unique(attribute, collection)
    every_unique(attribute, collection).length
  end

  # Helper method; possibly unnecessary if goals pulled from games_teams
  def goals(game)
    game.home_goals.to_i + game.away_goals.to_i
  end

  # Helper method
  def total_goals(games)
    games.sum { |game| goals(game) }
  end

  # Helper method
  def average_goals_in(games)
    (total_goals(games) / total_unique("game_id", games).to_f).round(2)
  end

  # Iteration 2 required method
  def average_goals_per_game
    average_goals_in(@games)
  end

  # Helper method
  def all_games_in_season(season)
    @games.select { |game| game.season == season }
  end

  # Iteration 2 required method
  def average_goals_by_season
    every_unique("season", @games).reduce({}) do |hash, season|
      hash[season] = average_goals_in(all_games_in_season(season))
      hash
    end
  end

  # Helper method
  def home_teams
    every_unique("home_team_id", @games)
  end

  # Helper method designed to be reusable; consider moving to a parent Collection class
  def find_by_in(element, attribute_str, collection)
    collection.find_all { |member| member.send(attribute_str) == element }
  end

  def all_home_games_of_team(team_id)
    find_by_in(team_id, "home_team_id", @games)
  end

  # Helper method
  def total_home_games(team)
    all_home_games_of_team(team).count
  end

  # Helper method
  def total_home_goals(team)
    all_home_games_of_team(team).sum { |game| game.home_goals.to_i }
  end

  # Helper method
  def average_home_score_of_team(team_id)
    total_home_goals(team_id) / total_home_games(team_id).to_f
  end

  # Iteration 3 required method
  def highest_scoring_home_team
    home_teams.max_by do |home_team_id|
      average_home_score_of_team(home_team_id)
    end
  end

  # Iteration 3 required method
  def lowest_scoring_home_team
    home_teams.min_by do |home_team_id|
      average_home_score_of_team(home_team_id)
    end
  end

  def away_teams
    every_unique("away_team_id", @games)
  end

  def all_away_games_of_team(team_id)
    find_by_in(team_id, "away_team_id", @games)
  end

  # Helper method
  def total_away_games(team)
    all_away_games_of_team(team).count
  end

  # Helper method
  def total_away_goals(team)
    all_away_games_of_team(team).sum { |game| game.away_goals.to_i }
  end

  # Helper method
  def average_away_score_of_team(team_id)
    total_away_goals(team_id) / total_away_games(team_id).to_f
  end

  # Iteration 3 required method
  def highest_scoring_visitor
    away_teams.max_by do |away_team_id|
      average_away_score_of_team(away_team_id)
    end
  end

  # Iteration 3 required method
  def lowest_scoring_visitor
    away_teams.min_by do |away_team_id|
      average_away_score_of_team(away_team_id)
    end
  end

  def games_with_team(team_id)
    find_by_in(team_id, "home_team_id", @games) + find_by_in(team_id, "away_team_id", @games)
  end

  def games_with_team_in_season(team_id, season)
    games_with_team(team_id).select do |game|
      game.season == season
    end
  end

  def away_win?(game)
    game.away_goals > game.home_goals
  end

  def home_win?(game)
    game.home_goals > game.away_goals
  end

  def away_games_in_season(team_id, season)
    all_away_games_of_team(team_id).select do |game|
      game.season == season
    end
  end

  def home_games_in_season(team_id, season)
    all_home_games_of_team(team_id).select do |game|
      game.season == season
    end
  end

  def total_away_wins(team_id, season)
    away_games_in_season(team_id, season).count do |game|
      away_win?(game)
    end
  end

  def total_home_wins(team_id, season)
    home_games_in_season(team_id, season).count do |game|
      home_win?(game)
    end
  end

  def total_team_wins(team_id, season)
    total_home_wins(team_id, season) + total_away_wins(team_id, season)
  end

  def team_win_percentage(team_id, season)
    (total_team_wins(team_id, season) / games_with_team_in_season(team_id, season).length.to_f).round(2)
  end

  def total_non_tie_games(team_id, season)
    games_with_team_in_season(team_id, season).reject do |game|
      game.away_goals == game.home_goals
    end.length
  end

  def unique_seasons
    @games.map {|game| game.season}.uniq
  end

  def team_seasons(team_id)
    games_with_team(team_id).map do |game|
      game.season
    end.uniq
  end

  def best_season(team_id)
    team_seasons(team_id).max_by do |season|
      team_win_percentage(team_id, season)
    end
  end

  def worst_season(team_id)
    team_seasons(team_id).min_by do |season|
      team_win_percentage(team_id, season)
    end
  end

  def total_wins_across_seasons(team_id)
    unique_seasons.sum do |season|
      games_with_team_in_season(team_id, season) != nil ? total_team_wins(team_id, season) : 0
    end
  end

  def average_win_percentage(team_id)
    (total_wins_across_seasons(team_id).to_f / games_with_team(team_id).length.to_f).round(2)
  end

  def total_team_ties_in_season(team_id, season)
    games_with_team_in_season(team_id, season).count do |game|
      game.away_goals == game.home_goals
    end
  end
end
