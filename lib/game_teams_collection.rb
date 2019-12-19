require_relative "game_teams"
require "csv"

class GameTeamsCollection
  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map { |row| GameTeams.new(row) }
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

  def team_win_percentage(hash, team)
    wins = hash[team].count { |game_team| game_team.result == "WIN" }
    number_of_games = hash[team].length
    percentage(wins, number_of_games)
  end

  def winningest_team_id
    hash = game_teams_hash
    hash.each do |key, value|
      hash[key] = team_win_percentage(hash, key)
    end
    hash.max_by { |key, value| value }[0]
  end

  def home_percentage(hash, team)
    home_games = hash[team].find_all { |game_team| game_team.hoa == "home" }
    home_wins = home_games.count { |game_team| game_team.result == "WIN"}
    percentage(home_wins, home_games.length)
  end

  def away_percentage(hash, team)
    home_games = hash[team].find_all { |game_team| game_team.hoa == "away" }
    home_wins = home_games.count { |game_team| game_team.result == "WIN"}
    percentage(home_wins, home_games.length)
  end

  def best_fans_id
    hash = game_teams_hash
    hash.each do |key, value|
      hash[key] = home_percentage(hash, key)
    end
    hash.max_by { |key, value| value }[0]
  end
end
