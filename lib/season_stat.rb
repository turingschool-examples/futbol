module SeasonStat

  def team_info(team_id)
    team_info_hash = Hash.new
    team_info_hash["team_id"] = team_id
    team_info_hash["franchise_id"] = all_teams[team_id].franchise_id
    team_info_hash["team_name"] = all_teams[team_id].team_name
    team_info_hash["abbreviation"] = all_teams[team_id].abbreviation
    team_info_hash["link"] = all_teams[team_id].link
    team_info_hash
  end

  def seasons_to_game_teams(team_id)
    team_game_id = 0
    season_games = Hash.new
    all_game_teams.each do |game_id, hash_pair|
      hash_pair.each do |key, game_team_obj|
        if team_id == game_team_obj.team_id
          team_game_id = game_team_obj.game_id
          season_games[all_games[team_game_id].season] ||= []
          season_games[all_games[team_game_id].season] << game_team_obj
        end
      end
    end
    season_games
  end

  def best_season(team_id)
    best_season_var = seasons_to_game_teams(team_id).max_by do |season, array_gameteams|
      wins = array_gameteams.count do |game_team_obj|
        game_team_obj.result == "WIN"
      end
      total_games = array_gameteams.count do |game_team_obj|
        game_team_obj
      end
      wins / total_games.to_f
    end
    best_season_var[0]
  end

  def worst_season(team_id)
    worst_season_var = seasons_to_game_teams(team_id).min_by do |season, array_gameteams|
      wins = array_gameteams.count do |game_team_obj|
        game_team_obj.result == "WIN"
      end
      total_games = array_gameteams.count do |game_team_obj|
        game_team_obj
      end
      wins / total_games.to_f
    end
    worst_season_var[0]
  end

  def average_win_percentage(team_id)
    wins = []
    games = []
    all_game_teams.each do |game_id, hash_pair|
      hash_pair.each do |key, game_team_obj|
        if team_id == game_team_obj.team_id
          if game_team_obj.result == "WIN"
            wins << game_team_obj
          end
          games << game_team_obj
        end
      end
    end
    (wins.length / games.length.to_f).round(2)
  end
end
