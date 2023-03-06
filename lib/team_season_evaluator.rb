module TeamSeasonEvaluator
  
  def evaluate_seasons(team_id)
    team_season_average = {}
    @seasons_by_id.each do |season, season_data|
      these_games = season_data[:game_teams].select{|game_team| game_team.team_id == team_id}
      team_season_average[season] = these_games.select{|game| game.result == "WIN"}.length / 
        these_games.length.to_f
    end
    team_season_average
  end
end