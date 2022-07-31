require './lib/game_statistics'

module GameStatsable


  def goals_scored
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end
  end


  def percentage_wins_for_team_playing(home_or_away)
    wins = 0
    total_games = 0
  
  @game_teams_data.each do |row|
      # if row[:hoa] == (@team_home_or_away)   #evaluated outcome
        
      if row[:hoa] == (home_or_away)
  
      if row[:result] == 'WIN'
          wins += 1
          total_games += 1
      
        elsif row[:result] == 'LOSS'|| 'TIE'
          total_games += 1
        end
      end
    end
    (wins / total_games.to_f).round(2)
  end
end