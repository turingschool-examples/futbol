
require "csv"
# require_relative 'game'
# require_relative 'team'
# require_relative 'game_teams'


class StatTracker
    attr_reader :games,
                :teams,
                :game_teams

    def initialize(location_paths)
        @games = create_games_array(location_paths[:games])
        @teams = create_teams_array(location_paths[:teams])
        @game_teams = create_game_teams_array(location_paths[:game_teams])
    end

    def self.from_csv(location_paths)
        StatTracker.new(location_paths)
    end

    def create_games_array(game_path)
        games = []
        CSV.foreach(game_path, headers: true) do |info|
            games << Game.new(info)
        end
        games
    end

    def create_teams_array(team_path)
      team = []
      CSV.foreach(team_path, headers: true) do |info|
          team << Team.new(info)
      end
      team
    end

    def create_game_teams_array(game_team_path)
      game_teams = []
      CSV.foreach(game_team_path, headers: true) do |info|
          game_teams << GameTeam.new(info)
      end
      game_teams
    end
end
