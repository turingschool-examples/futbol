require 'csv'
require_relative 'game_statistics'
require_relative 'league_statistics'
require_relative 'season_statistics'
require_relative 'team_statistics'

class StatTracker
  attr_reader :data

  def initialize(locations)
    game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    games = CSV.read locations[:games], headers: true, header_converters: :symbol
    teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @data = {game_teams: game_teams, games: games, teams: teams}
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end