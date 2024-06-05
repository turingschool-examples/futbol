require 'csv'
require_relative 'team'
require_relative 'game_teams'
require_relative 'league'
require_relative 'game'
require_relative 'season'

class StatTracker
    attr_reader :game_data, :team_data, :game_teams_data, :game, :league, :season
    def initialize(locations)
        @game_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
        @team_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
        @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

        @game_data = @game_data.map do |game|
            Game.new(game.to_h)
        end      

        @team_data = team_data.map do |team|
            Team.new(team.to_h)
        end

        @game_teams_data = game_teams_data.map do |game_teams|
            Game_teams.new(game_teams.to_h)
        end




    end

    
end
