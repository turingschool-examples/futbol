require 'csv'

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

    def initialize(game)
        @game_id = game[:game_id]
        @season = game[:season]
        @type = game[:type]
        @date_time = game[:date_time]
        @away_team_id = game[:away_team_id]
        @home_team_id = game[:home_team_id]
        @away_goals = game[:away_goals]
        @home_goals = game[:home_goals]
        @venue = game[:venue]
        @venue_link = game[:venue_link]
    end

end