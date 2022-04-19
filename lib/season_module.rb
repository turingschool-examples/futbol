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
    return game_teams_by_season.flatten!
  end

  def SeasonModule.coach_wins_losses_for_season(game_teams_by_season)
    coach_wins_losses = {}
    game_teams_by_season.each do |game_team|
      if coach_wins_losses.keys.include?(game_team.head_coach)
        coach_wins_losses[game_team.head_coach] << game_team.result
      else
        coach_wins_losses[game_team.head_coach] = [game_team.result]
      end
    end
    return coach_wins_losses
  end

end
