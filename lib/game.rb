

class Game
    attr_reader :season_id, 
                :away_team_id, 
                :home_team_id, 
                :away_goals, 
                :home_goals
                
    def initialize(season_id, away_team_id, home_team_id, away_goals, home_goals)
        @season_id = season_id
        @away_team_id = away_team_id
        @home_team_id = home_team_id
        @away_goals = away_goals
        @home_goals = home_goals
    end
end