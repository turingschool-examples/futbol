module Coach
  
  def coach_wins(season_id)
    season_games = @seasons_by_id[season_id][:game_teams]
    coach_stats = Hash.new {|coach, games| coach[games] = [0, 0]}
    coach_win_percentage = Hash.new
    season_games.each do |game|
      coach_stats[game.head_coach][0] += 1
      if game.result == "WIN"
      coach_stats[game.head_coach][1] += 1
      end
    end
    coach_stats.each do |coach, stats|
     coach_win_percentage[coach] = stats[1] / stats[0].to_f
    end
    coach_win_percentage
  end
end