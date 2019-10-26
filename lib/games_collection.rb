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

  def unique_seasons
    @games.map {|game| game.season}.uniq
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

  # def team_games(team_id)
  #   team_games_list = []
  #   @games.each do |game|
  #     if team_id == game.home_team_id || team_id == game.away_team_id
  #       team_games_list << game
  #     end
  #   end
  #   team_games_list
  # end

  def total_wins_by_team(team_id)
    games_with_team(team_id).count { |game| game.result == "WIN" }
  end



  def find_by_in(element, attribute, collection)
    collection.find_all { |member| member.send(attribute) == element }
  end

  def games_with_team(team_id)
    find_by_in(team_id, "home_team_id", @games) + find_by_in(team_id, "away_team_id", @games)
  end

  def away_win?(game)
    game.away_goals > game.home_goals
  end
end
