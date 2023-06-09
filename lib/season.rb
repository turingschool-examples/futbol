require "csv"

class Season
    attr_reader :games,
                :season,
                :game_teams,
                :game_ids,
                :team_ids,
                :teams,
                :team_tackles

    def initialize(game_file, game_team_file, season, team_data)
        @games = []
        @game_teams = []
        @season = season
        @game_ids = []
        @teams = []
        @team_ids = []
        @team_tackles = {}
        generate_games(game_file)
        generate_game_ids
        generate_game_teams(game_team_file)
        generate_teams(team_data)
        generate_team_ids
        tackle_data
    end

    def generate_games(game_file)
        game_lines = CSV.open game_file, headers: true, header_converters: :symbol
        game_lines.each do |line|
            if line[:season] == @season
                @games << Game.new(line)
            end
        end
    end

    def generate_game_ids
        @games.each do |game|
            @game_ids << game.game_id
        end
    end
    
    def generate_game_teams(game_team_file)
        game_lines = CSV.open game_team_file, headers: true, header_converters: :symbol
        game_lines.each do |line|
            if @game_ids.include?(line[:game_id])
                @game_teams << GameTeam.new(line)
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

    def tackle_data
        team_tackles = Hash.new(0)
        @game_teams.each do |game_team|
            team_id = game_team.team_id
            tackles = game_team.tackles
            team_tackles[team_id] += tackles
        end
        @team_tackles = team_tackles
    end
end