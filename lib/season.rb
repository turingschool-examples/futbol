require 'csv'

class Season
    attr_reader :games,
                :type,
                :season,
                :team_stats,
                :game_ids

    def initialize(game_file, game_team_file, season, type)
        @games = []
        @team_stats = []
        @season = season
        @type = type
        @game_ids = []
        generate_games(game_file)
        generate_game_ids
        generate_team_stats(game_team_file)
    end

    def generate_games(game_file)
        game_lines = CSV.open game_file, headers: true, header_converters: :symbol
        game_lines.each do |line|
            if line[:season] == @season && line[:type] == @type
                @games << Game.new(line)
            end
        end
    end

    def generate_game_ids
        @games.each do |game|
            @game_ids << game.game_id
        end
    end
    
    def generate_team_stats(game_team_file)
        game_lines = CSV.open game_team_file, headers: true, header_converters: :symbol
        game_lines.each do |line|
            if @game_ids.include?(line[:game_id])
                @team_stats << line
            end
        end
    end

    def games_count
        @games.count
    end

    def average_goals_per_game
        averages = @games.map do |game|
            game.goals_averaged
        end
        (averages.sum / averages.length).round(2)
    end
end