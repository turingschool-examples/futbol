class GameStats 
    attr_reader :highest_score,
                :lowest_score,
                :home_team, 
                :away_team
                
    def initialize(highest_score, lowest_score, home_team, away_team)
        @highest_score = highest_score
        @lowest_score = lowest_score
        @home_team = home_team
        @away_team = away_team
    end 
end