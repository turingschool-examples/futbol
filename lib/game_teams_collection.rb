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

  def games_by_team_id(team_id)
    @game_teams_array.select {|game_team| game_team.team_id.to_i == team_id}
  end

  def total_wins_per_team
    @game_teams_array.select {|game_team| game_team.result == "WIN"}.count
  end

  def total_games_per_team(team_id)
    games_by_team_id(team_id).length
  end

  def average_win_percentage(team_id)
    total_wins_per_team / total_games_per_team(team_id).to_f
  end

  def total_goals_by_team_id(team_id)
    games_by_team_id(team_id).sum {|game_team| game_team.goals.to_i}
  end

  def average_goals_per_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f / games_by_team_id(team_id).count).to_f
  end

  def unique_team_ids
    @game_teams_array.uniq {|game_team| game_team.team_id.to_i}.map { |game_team| game_team.team_id.to_i}
  end

  def best_offense
    unique_team_ids.max_by {|team_id| average_goals_per_team_id(team_id)}
  end

  def worst_offense
    unique_team_ids.min_by {|team_id| average_goals_per_team_id(team_id)}
  end

  def game_teams_hash
    @game_teams_array.reduce({}) do |hash, game_teams|
      hash[game_teams.team_id] << game_teams if hash[game_teams.team_id]
      hash[game_teams.team_id] = [game_teams] if hash[game_teams.team_id].nil?
      hash
    end
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
