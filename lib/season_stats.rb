module SeasonStats
  def winningest_coach(season)
    coach_wins = {}
    last_game_id = nil
    @game_teams.each do |game_team|
      if game_team[:game_id].nil?
        last_game_id = game_team[:game_id]
      elsif game_team[:game_id] == last_game_id
        if coach_wins.include?(game_team[:head_coach])
          coach_wins[game_team[:head_coach]] = (+= win counter here)
        else
          coach_wins[game_team[:head_coach]] = game_team[:result] ==  "WIN" ? 1 : 0
      else
        last_game_id = game_team[:game_id]
    end

  end
end
#need season number
#iterate through game_teams
#possible duplicate
#each loop will have to skip an iteration
#or iterate twice
#possilbe if statment on same game
#set game id to variable locally then reassign
#determine if game is the same then if not the same pull other HC to add
