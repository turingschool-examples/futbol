require 'csv'

class Season
    attr_reader :games

    def initialize(game_file, game_team_file, season, type)
        @games = []
    end
end