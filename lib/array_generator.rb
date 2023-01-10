require_relative 'game'
require_relative 'team'
require_relative 'game_team'

module ArrayGenerator
    def create_games_array(games_path)
        games = []
        CSV.foreach(games_path, headers: true, header_converters: :symbol) do |info|
            games << Game.new(info)
        end
        games
    end

    def create_teams_array(teams_path)
        teams = []
        CSV.foreach(teams_path, headers: true, header_converters: :symbol) do |info|
            teams << Team.new(info)
        end
        teams
    end

    def create_game_teams_array(game_teams_path)
        game_teams = []
        CSV.foreach(game_team_path, headers: true, header_converters: :symbol) do |info|
            game_teams << GameTeam.new(info)
        end
        game_teams
    end
end