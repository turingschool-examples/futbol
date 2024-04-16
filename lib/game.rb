

class Game
    attr_reader :game_id,
                :season_id, 
                :away_team_id, 
                :home_team_id, 
                :away_goals, 
                :home_goals
                
    def initialize(game_id, season_id, away_team_id, home_team_id, away_goals, home_goals)
        @game_id = game_id
        @season_id = season_id
        @away_team_id = away_team_id
        @home_team_id = home_team_id
        @away_goals = away_goals
        @home_goals = home_goals
    end
end