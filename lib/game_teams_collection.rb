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
    numerator = hash[team].count { |game| game.result == "WIN" }
    denominator = hash[team].length
    percentage(numerator, denominator)
  end

  def winningest_team_id
    hash = game_teams_hash
    hash.each do |key, value|
      hash[key] = team_win_percentage(hash, key)
    end
    hash.max_by { |key, value| value }[0]
  end
end
