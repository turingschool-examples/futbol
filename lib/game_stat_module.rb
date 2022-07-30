module GameStatsable


  def goals_scored
  scores = @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
  end


  def percentage_home_wins
  wins = 0
  total_games = 0

  @game_teams_data.each do |row|
      if row[:hoa] == 'home'#evaluated outcome
        
        if row[:result] == 'WIN'#evaluated outcome
          wins += 1
          total_games += 1
      
        elsif row[:result] == 'LOSS' # or ##other outcomes
          total_games += 1

        elsif row[:result] == 'TIE'# if or above works, delete this calc
          total_games += 1
        end
      end
  end
    (wins / total_games.to_f).round(2)
end


end