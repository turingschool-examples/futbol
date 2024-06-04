require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
    attr_reader :games, :teams, :game_teams

    def self.from_csv(locations)
        games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
        teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
        game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

        StatTracker.new(games, teams, game_teams)
    end

    def initialize(games, teams, game_teams)
        @games = games
        @teams = teams
        @game_teams = game_teams
    end
end