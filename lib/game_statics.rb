class GameStatics

    def initialize(game_object_array)
      @games = game_object_array
    end
  
    def highest_total_score
        highest_score = 0
      
        @games.each do |game|
          total_score = game["home_goals"].to_i + game["away_goals"].to_i
          highest_score = total_score if total_score > highest_score
        end
      
        highest_score
    end

    def lowest_total_score
        lowest_score = nil

        @games.each do |game|
            total_score = game["home_goals"].to_i + game["away_goals"].to_i
            lowest_score = total_score if lowest_score.nil? || total_score < lowest_score
        end

        lowest_score
    end
           
end
  