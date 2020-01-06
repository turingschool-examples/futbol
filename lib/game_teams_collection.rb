require_relative "game_teams"
require_relative 'csv_loadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
    @game_teams_by_id = game_teams_hash
  end

  def create_game_teams_array(file_path)
    load_from_csv(file_path, GameTeams)
  end

  def game_teams_hash
    @game_teams_array.reduce({}) do |hash, game_teams|
      hash[game_teams.team_id] << game_teams if hash[game_teams.team_id]
      hash[game_teams.team_id] = [game_teams] if hash[game_teams.team_id].nil?
      hash
    end
  end

  def home_games_only
    home_only = {}
    @game_teams_by_id.each do |team_id, games|
      home_only[team_id] = games.find_all do |game|
        game.hoa == "home"
      end
    end
    home_only
  end

  def away_games_only
    away_only = {}
    @game_teams_by_id.each do |team_id, games|
      away_only[team_id] = games.find_all do |game|
        game.hoa == "away"
      end
    end
    away_only
  end

  def home_games_only_average
    home_only_average = {}
    home_games_only.each do |game_id, games|
    home_only_average[game_id] = (games.sum { |game| game.goals.to_i} / games.length.to_f).round(2)
    end
    home_only_average
  end

  def away_games_only_average
    away_only_average = {}
    away_games_only.each do |game_id, games|
    away_only_average[game_id] = (games.sum { |game| game.goals.to_i} / games.length.to_f).round(2)
    end
    away_only_average
  end

  def highest_scoring_home_team
    new = []
    home_games_only_average.each do |game_id, average|
      if average == home_games_only_average.values.max
      new << game_id.to_i
      end
    end
    new
  end

  def lowest_scoring_home_team
    new = []
    home_games_only_average.each do |game_id, average|
      if average == home_games_only_average.values.min
      new << game_id.to_i
      end
    end
    new
  end

  def highest_scoring_visitor
    new = []
    away_games_only_average.each do |game_id, average|
      if average == away_games_only_average.values.max
      new << game_id.to_i
      end
    end
    new
  end

  def lowest_scoring_visitor
    new = []
    away_games_only_average.each do |game_id, average|
      if average == away_games_only_average.values.min
      new << game_id.to_i
      end
    end
    new
  end

  def percentage(numerator, denominator) #to-do: make Calculatable module
    return ((numerator.to_f / denominator) * 100).round(2)
  end

  def team_win_percentage(games_hash, team, hoa = nil)
    team_games = Hash.new
    if hoa
      team_games[team] = games_hash[team].find_all { |game_team| game_team.hoa == hoa }
    else
      team_games[team] = games_hash[team]
    end
    wins = team_games[team].count { |game_team| game_team.result == "WIN" }
    percentage(wins, team_games[team].length)
  end

  def winningest_team_id
    win_percentages = Hash.new
    @game_teams_by_id.each do |key, value|
      win_percentages[key] = team_win_percentage(@game_teams_by_id, key)
    end
    win_percentages.max_by { |key, value| value }[0]
  end

  def hoa_differences(all_games)
    diffs = Hash.new{}
    all_games.each do |key, value|
      diffs[key] = team_win_percentage(all_games, key, "home") - team_win_percentage(all_games, key, "away")
    end
    diffs
  end

  def best_fans_id
    hoa_differences(@game_teams_by_id).max_by { |key, value| value }[0]
  end

  def worst_fans_ids
    hoa_diffs = hoa_differences(@game_teams_by_id)
    worst_fan_teams = hoa_diffs.find_all { |key, value| value < 0 }
    worst_fan_teams.map { |element| element[0] }
  end
end
