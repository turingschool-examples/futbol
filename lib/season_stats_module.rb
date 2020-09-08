module SeasonStatistics

  def find_all_games_from_season(season_id)
    @games.find_all do |game|
      game.season == season_id
    end
  end
#above returns an array

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
    coaches_hash = Hash.new
    season_coaches(season_id).find_all do |all_coaches|
       coach = all_coaches

    #This would give total games for coach
      total_games = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach
      end

  #this would give total number of wins for coach.
      total_wins = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach && game.result == "WIN"
      end
      coaches_hash[coach] = ((total_wins.to_f/total_games.to_f) * 100).round(2)

    end
    coaches_hash.values.max
  end

  def worst_coach(season_id)
    coaches_hash = Hash.new
    season_coaches(season_id).find_all do |all_coaches|
       coach = all_coaches

    #This would give total games for coach
      total_games = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach
      end

  #this would give total number of wins for coach.
      total_wins = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach && game.result == "WIN"
      end
      coaches_hash[coach] = ((total_wins.to_f/total_games.to_f) * 100).round(2)

    end
    coaches_hash.values.min
  end

#could make a helper method and simplify winningest and worst coaches





end
