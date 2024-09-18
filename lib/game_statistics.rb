class GameStatics

    def initialize(game_data, team_data)
        @game_data = game_data
        @team_data = team_data
    end

    #def percent_home_wins
     #   @game_data =

   #end

    def perecent_vistor_wins

    end

    def total_score
        @game_data.map do |game|
            home_goals = games.home_goals
            
        end
    end

    def highest_total_score
        total_score.max
    end

    def lowest_total_score
        total_score.min
    end
end
