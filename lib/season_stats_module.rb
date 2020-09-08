module SeasonStatistics

  def find_all_games_from_season(season_id)
    @games.find_all do |game|
      game.season == season_id
    end
  end

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

      total_games = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach
      end

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

      total_games = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach
      end

      total_wins = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach && game.result == "WIN"
      end
      coaches_hash[coach] = ((total_wins.to_f/total_games.to_f) * 100).round(2)
    end
    coaches_hash.values.min
  end

#could make a helper method and simplify winningest and worst coaches

  def most_accurate_team(season_id)
    team_hash = Hash.new
    season_teams(season_id).find_all do |all_teams|
      team = all_teams

      total_shots = game_teams_data_for_season(season_id).each do |game|
        team_shots = 0
        if game.team_id == team
          team_shots += game.shots
        end
        return team_shots
      end

      total_goals = game_teams_data_for_season(season_id).each do |game|
        team_goals = 0
        if game.team_id == team
          team_goals += game.goals
        end
        return team_goals
      end

      shot_ratio = (total_goals.to_f / total_shots.to_f).round(2)
      team_hash[team] = shot_ratio
    end

  end

  def season_teams(season_id)
    game_teams_data_for_season(season_id).map do |game|
      game.team_id
    end.uniq
  end



end
