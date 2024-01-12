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

    def initialize(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue)
        @game_id = game_id.to_i
        @season = season
        @type = type
        @date_time = data_time
        @away_team_id = away_team_id.to_i
        @home_team_id = home_team_id.to_i
        @away_goals = away_goals.to_i
        @home_goals = home_goals.to_i
        @venue = venue
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