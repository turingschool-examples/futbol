class Game
    attr_reader :game_id,
                :season, 
                :type, 
                :data_time, 
                :away_team_id, 
                :home_team_id,
                :away_goals,
                :home_goals,
                :venue
    def initialize(data_attributes)
        @game_id = data_attributes[:game_id].to_i
        @season = data_attributes[:season]
        @type = data_attributes[:type]
        @date_time = data_attributes[:data_time]
        @away_team_id = data_attributes[:away_team_id]
        @home_team_id = data_attributes[:home_team_id]
        @away_goals = data_attributes[:away_goals].to_i
        @home_goals = data_attributes[:home_goals].to_i
        @venue = data_attributes[:venue]
    end 

   