module Modable

  def winningest_coach_mod(season)
    array = []
    @game_teams_manager.game_teams_array.each do |game|
      if @all_games.include?(game.game_id)
        array << game
      end
    end
    hash = array.group_by do |game| game.head_coach
    end
    games_played = hash.each do |k,v| hash[k] = v.length
    end

    games_won = array.select do |game| game.result == "WIN"
    end
    games_won_hash = games_won.group_by do |game| game.head_coach
    end
    numb_games_won = games_won_hash.each do |k,v| games_won_hash[k] = v.length
    end
    numbers = []
    @result = {}
    numb_games_won.each do |k,v| games_played.each do |k1,v1|
       if k == k1
          @result[k] = (v.to_f/v1.to_f).round(4)
       end
     end
   end
   @result.max_by(&:last).first
  end
end
