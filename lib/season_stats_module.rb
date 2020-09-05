module SeasonStatistics
  @games = games
  @teams = teams
  @game_teams = game_teams

  def find_all_games_from_season(season_id)
    games.find_all do |game|
      game.season == season_id
    end
  end
#above returns an array

  def array_of_game_id_from_season(season_id)
    find_all_games_from_season(season_id).map do |season|
      season.game_id
    end
  end

  def find_game_teams_data_for_season(season_id)
    
  end

  # def coaches_and_game_id_hash
  #   coach_and_game = Hash.new
  #   @row.sort do |coach, game_id|
  #     coach_and_game[:coach] = :game_id
  #   end
  # end


end
