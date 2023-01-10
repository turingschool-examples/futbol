require_relative 'array_generator'

class Game
    attr_reader :game_id,
                :season,
                :type,
                :date_time,
                :away_team_id,
                :home_team_id,
                :away_goals,
                :home_goals,
                :venue,
                :venue_link

    def initialize(info)
        @game_id = info[:game_id]
        @season = info[:season]
        @type = info[:type]
        @date_time = info[:date_time]
        @away_team_id = info[:away_team_id]
        @home_team_id = info[:home_team_id]
        @away_goals = info[:away_goals].to_i
        @home_goals = info[:home_goals].to_i
        @venue = info[:venue]
        @venue_link = info[:venue_link]
    end
    
    def self.read_file(games_path)
        games = []
        CSV.foreach(games_path, headers: true, header_converters: :symbol) do |info|
            games << Game.new(info)
        end
        games
    end
end
