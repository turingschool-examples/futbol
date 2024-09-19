class GameStatics

    def initialize(game_data, team_data)
        @game_data = game_data
        @team_data = team_data
    end

    #def percent_home_wins
     #   @game_data =

   #end

    def total_score
        @game_data.map do |game|
            home_goals = games.home_goals
            away_goals = game_data.away_goals
            home_goals + away_goals
        end
    end

    def highest_total_score
        total_score.max
    end

    def lowest_total_score
        total_score.min
    end

    def perecent_home_wins
        total_games = @game_data.size
        home_wins = @game_data.count do |game|
            game.home_goals > game.away_goals
        end

        perecentage = (home_wins.to_f / total_games)
        perecentage.round(2)
        require 'pry'
    end
end
