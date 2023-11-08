require 'CSV'
require './lib/game' #should be the spec helper

class GameList 
    attr_reader :games

    def initialize(path, stat_tracker)
        @games = create_games(path)
    end
    
    def create_games(path)
        data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
        data.map do |datum|
            Game.new(datum,self)
        end
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