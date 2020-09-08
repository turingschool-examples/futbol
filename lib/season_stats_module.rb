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

# create hash with coaches as keys
    # coach_hash = Hash.new
    # season_coaches(season_id).each do |coach|
    #   coach_hash[coach] = nil
    # end


    season_coaches(season_id).max_by do |coaches|
       coach = coaches

    #This would give total games for coach
      total_games = game_teams_data_for_season(season_id).find_all do |game|
        game.head_coach == coach
      end.length
  #this would give total number of wins for coach.
      total_wins = game_teams_data_for_season(season_id).find_all do |game|
        game.head_coach == coach && game.result == "WIN"
      end.length

      (total_wins.to_f/total_games.to_f) * 100
    end
  end


end
