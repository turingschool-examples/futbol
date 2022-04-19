require './required_files'

module SeasonModule

  def SeasonModule.game_teams_for_season(season, season_games, game_teams)
    game_teams_by_season = []
    season_games.each do |game|
      matching_game_team = game_teams.find_all{|g_t| g_t.game_id == game.game_id}
      if matching_game_team
        game_teams_by_season << matching_game_team
      end
    end
    game_teams_by_season.flatten!
  end

end
