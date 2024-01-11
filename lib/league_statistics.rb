require 'csv'
require './lib/game_team'
require './lib/team'

class LeagueStatistics
  attr_reader :teams,
              :game_teams

  def initialize(teams, game_teams)
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(game_teams_filepath,teams_filepath)
    game_teams = []

    CSV.foreach(game_teams_filepath, headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end

    teams = []

    CSV.foreach(teams_filepath, headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)
    end

    new(teams, game_teams)
  end
end
