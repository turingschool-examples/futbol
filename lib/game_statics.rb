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
           
end
  