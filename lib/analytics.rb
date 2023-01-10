module Analytics
    def total_teams_average(game_team_collection)
      teams_total_scores = Hash.new{0}
      teams_total_games = Hash.new{0}
      teams_total_averages = Hash.new{0}
    
      game_team_collection.add_total_score_and_games(teams_total_scores, teams_total_games)
    
      teams_total_scores.each do |key, value|
        teams_total_averages[key] = (value / teams_total_games[key].to_f).round(5)
      end

      teams_total_averages
    end
end