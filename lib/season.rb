require "csv"

class Season
    attr_reader :games,
                :type,
                :season,
                :team_stats,
                :game_ids,
                :team_ids,
                :teams

    def initialize(game_file, game_team_file, season, type, team_data)
        @games = []
        @team_stats = []
        @season = season
        @type = type
        @game_ids = []
        @teams = []
        @team_ids = []
        generate_games(game_file)
        generate_game_ids
        generate_team_stats(game_team_file)
        generate_teams(team_data)
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

    def generate_team_ids
        @games.each do |game|
            if !@team_ids.include?(game.away_team_id)
                @team_ids << game.away_team_id
            end
            if !@team_ids.include?(game.home_team_id)
                @team_ids << game.home_team_id
            end
        end
    end

    def generate_teams(team_data)
        game_lines = CSV.open team_data, headers: true, header_converters: :symbol
        game_lines.each do |line|
            if !@team_ids.include?(line[:team_id])
                @teams << Team.new(line)
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