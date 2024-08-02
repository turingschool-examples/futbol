# require_relative './helper_class'

class Game
    attr_reader :game_id,
                :season,
                :type,
                :away_team_id,
                :home_team_id,
                :away_goals,
                :home_goals,
                :venue_link

    def initialize(game_data)
        @game_id = game_data[:game_id]
        @season = game_data[:season]
        @type = game_data[:type]
        @away_team_id = game_data[:away_team_id]
        @home_team_id = game_data[:home_team_id]
        @away_goals = game_data[:away_goals].to_i
        @home_goals = game_data[:home_goals].to_i
        @venue_link = game_data[:venue_link]    
    end

end