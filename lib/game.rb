class Game
    attr_reader :game_id, 
                :season, 
                :type,
                :date_time,
                :away_team_id,
                :home_team_id,
                :away_goals,
                :home_goals,
                :venue

    def initialize(data)
        @game_id = data[:game_id].to_i
        @season = data[:season].to_i
        @type = data[:type]
        @date_time = data[:date_time] #NEED TO CONVERT TO DATE OBJECT
        @away_team_id = data[:away_team_id].to_i
        @home_team_id = data[:home_team_id].to_i
        @away_goals = data[:away_goals].to_i
        @home_goals = data[:home_goals].to_i
        @venue = data[:venue]
    end

    def total_goals
        @away_goals + @home_goals
    end
end