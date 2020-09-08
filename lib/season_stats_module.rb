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

  def season_coaches(season_id)
    game_teams_data_for_season(season_id).map do |game|
      game.head_coach
    end.uniq
  end

  def winningest_coach(season_id)
    coach_hash = Hash.new

    game_teams_data_for_season(season_id).each do |game|
      coach = game.head_coach
    #This would give total games for coach
      total_games = game_teams_data_for_season(season_id).find_all do |game|
        game.head_coach == coach
      end.length
  #this would give total number of wins for coach.
      total_wins = game_teams_data_for_season(season_id).find_all do |game|
        game.head_coach == coach && game.result == "WIN"
      end.length
    end
  end


end
