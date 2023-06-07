require 'csv'

class Season
    attr_reader :games,
                :type,
                :season

    def initialize(game_file, game_team_file, season, type)
        @games = []
        @season = season
        @type = type
        generate_games(game_file)
    end

    def generate_games(game_file)
        game_lines = CSV.open game_file, headers: true, header_converters: :symbol
        game_lines.each do |line|
            if line[:season] == @season && line[:type] == @type
                @games << Game.new(line)
            end
        end
    end

    def games_count
        @games.count
    end
end