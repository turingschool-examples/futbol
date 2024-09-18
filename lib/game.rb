class Game
    attr_reader :game_id,
                :seasons
                :type,
                :date_time,
                :away_team_id,
                :home_team_id,
                :away_goals,
                :home_goals,
                :venue,
                :venue_link
                
    def initialize(data)
        @game_id = data[:game_id]
        @season = data[:season]
        @type = data[:type]
        @data_time = data[:data_time]
        @away_team_id = data[:away_goals_id]
        @home_goals_id = data[:home_goals_id]
        @away_goals = data[:away_goals].to_i
        @home_goals = data[:home_goals].to_i
        @venue = data[:venue]
        @venue_link = data[:venue_link]
    end
end