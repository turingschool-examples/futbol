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
        @game_id = data_attributes[:game_id]
        @season = data_attributes[:season]
        @type = data_attributes[:type]
        @date_time = data_attributes[:data_time]
        @away_team_id = data_attributes[:away_team_id]
        @home_team_id = data_attributes[:home_team_id]
        @away_goals = data_attributes[:away_goals]
        @home_goals = data_attributes[:home_goals]
        @venue = data_attributes[:venue]
    end 

    def total_score
        @home_goals + @away_goals
    end

    def lowest_total_score

    end
    
    def percentage_home_wins
        
    end

    def percentage_visitor_wins

    end 

    def percentage_ties
    end

    def count_of_games_by_season

    end

    def average_goals_per_game

    end

    def average_goals_by_season

    end
end