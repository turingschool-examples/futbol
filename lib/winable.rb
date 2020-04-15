module Winable

  #for use in Game
  def win?(team_id)
    away_win = team_id == @away_team_id && @away_goals > @home_goals
    home_win =  team_id == @home_team_id && @home_goals > @away_goals
    return 1 if away_win || home_win
    0
  end

end
