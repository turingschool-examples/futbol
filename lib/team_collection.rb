require 'csv'
require_relative './team.rb'
require_relative './game_team.rb'

class TeamCollection
  attr_reader :total_teams

  def initialize(team_path, game_team_path)
    @total_games = create_game_team(game_team_path)
    @total_teams = create_teams(team_path)
  end

  def create_game_team(game_team_path)
    csv = CSV.read(game_team_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      GameTeam.new(row)
    end
  end

  def create_teams(team_path)
    csv = CSV.read(team_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      all_team_games = @total_games.find_all do |game|
        row[:team_id] == game.team_id
      end
      Team.new(row, all_team_games)
    end
  end

  def winningest_team
    @total_teams.max_by do |team|
      team.win_percentage
    end.team_name
  end
end
