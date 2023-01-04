
require 'csv'
# require_relative 'game'
# require_relative 'team'
# require_relative 'game_teams'


class StatTracker
    attr_reader :game,
                :teams,
                :game_teams

    def initialize(location_paths)
        @game = location_paths[:games]
        @teams = location_paths[:teams]
        @game_teams = location_paths[:game_teams]
    end

    def self.from_csv(location_paths)
        StatTracker.new(location_paths)
    end

    def location_paths
        games = []
        CSV.foreach(location_paths[:games], headers: true) do |info|
            games << Game.new(info)
        end
        games
    end
end
