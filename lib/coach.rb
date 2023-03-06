module Coach
  
  def coach_wins(season_id)
    season_games = @seasons_by_id[season_id][:game_teams]
    games_won_coach = Hash.new(0)
    games_played_coach = Hash.new(0)
    coach_win_percentage = Hash.new
    season_games.each do |game|
      games_played_coach[game.head_coach] += 1
      if game.result == "WIN"
      games_won_coach[game.head_coach] += 1
      end
    end
    games_played_coach.each do |coach, games|
      games_won_coach.each do |won_coach, won_games|
        if coach == won_coach
          coach_win_percentage[coach] = (won_games / games.to_f)
        end
        if !games_won_coach.include?(coach)
          coach_win_percentage[coach] = 0
        end
      end
    end
    coach_win_percentage
  end
end