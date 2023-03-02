require 'csv'
require 'team'
require 'game_teams'
require 'game'

class LeagueStats
  attr_reader :teams,
              :game_teams,
              :games

  def initialize
    @teams = CSV.open('./data/teams.csv', headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @game_teams = CSV.open('./data/game_teams.csv', headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
    @games = CSV.open('./data/games.csv', headers: true, header_converters: :symbol).map { |row| Game.new(row) }
  end

  def count_of_teams
    @teams.count
  end
end