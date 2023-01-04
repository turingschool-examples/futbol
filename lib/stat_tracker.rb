require 'csv'
class StatTracker

    def initialize(locations)
      @games = create_games(locations[:games])
      @teams = create_teams(locations[:teams])
      @game_teams = create_game_teams(locations[:game_teams])
    #   require 'pry'; binding.pry
    end

    def create_games(game_path)
        games = []
        CSV.foreach(game_path, headers: true, header_converters: :symbol ) do |info|
            games << Game.new(info)  
        end
        games
    end

    def create_teams(team_path)
        teams = []
        CSV.foreach(team_path, headers: true, header_converters: :symbol ) do |info|
            teams << Team.new(info)
        end
        teams
    end

    def create_game_teams(game_teams_path)
        game_teams = []
        CSV.foreach(game_teams_path, headers: true, header_converters: :symbol ) do |info|
            game_teams << GameTeam.new(info)  
        end
        game_teams
    end

    def self.from_csv(locations)
        new(locations)
    end
end