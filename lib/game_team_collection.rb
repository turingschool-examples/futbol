require 'csv'
require_relative 'gameteam'

class GameTeamCollection
  attr_reader :game_teams

  def initialize(csv_path)
    @game_teams = create_game_teams(csv_path)
  end

  def create_game_teams(csv_path)
    csv = CSV.read("#{csv_path}", headers: true, header_converters: :symbol)
    csv.map { |row| GameTeam.new(row) }
  end

  def total_game_teams
    @game_teams.length
  end

  def total_team_wins
    @game_teams.reduce(Hash.new(0)) do |acc, game_team|
      acc[game_team.team_id] +=1 if game_team.win?
      acc
    end
  end

  def total_games_per_team
    @game_teams.reduce(Hash.new(0)) do |acc, game_team|
      acc[game_team.team_id] +=1
      acc
    end
  end

  def team_win_percentage
    total_team_wins.merge(total_games_per_team) do |game_team, wins, games|
      (wins.to_f/games).round(2)
    end
  end

  def winningest_team_id
    team_win_percentage.max_by do |game_team, percentage|
      percentage
    end.first
  end
end
