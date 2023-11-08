require 'CSV'
require './lib/game' #should be the spec helper

class Games #class cant be plural?
    attr_reader :array

    def initialize
        @array = []
        array_fill #why is this here?
    end

    def array_fill
        CSV.foreach('./data/games.csv', headers: true, header_converters: :symbol) do |row|
            game_id      = row[:game_id].to_i
            season       = row[:season].to_i
            type         = row[:type].to_s
            date_time    = row[:date_time].to_s
            away_team_id = row[:away_team_id].to_i
            home_team_id = row[:home_team_id].to_i
            away_goals   = row[:away_goals].to_i
            home_goals   = row[:home_goals].to_i
            venue        = row[:venue].to_s
            venue_link   = row[:venue_link].to_s
        
            new_game = Game.new(game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link)
        
            @array.append(new_game)
        end
    end
end