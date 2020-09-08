module SeasonStatistics

  def find_all_games_from_season(season_id)
    @games.find_all do |game|
      game.season == season_id
    end
  end
#above returns an array


#maybe go back and try to just complare id in games
#with id in game_teams

  def array_of_game_id_from_season(season_id)
    find_all_games_from_season(season_id).map do |game|
      game.game_id
    end
  end

  def game_teams_data_for_season(season_id)
    @game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end
  end 

  # def list_of_coaches_by_season(season_id)
  #   coaches_by_season = {}
  #   game_teams_data_for_season(season_id).sort_by do |key, value|
  #     coaches_by_season[key.head_coach] = value
  #   end
  # end

  def winningest_coach(season_id)
    # win_count = game_teams_data_for_season(season_id).find do |season|
    #   (season.head_coach && (season.result == WIN))
    # end

    coach_results = {}
    game_teams_data_for_season(season_id).each do |season, game|
      coach_results[season.head_coach] = []
      game.each do |game|
        coach_results[season.head_coach] << season.find do |data|
          data == WIN
        end
      end
    end


  end


end
