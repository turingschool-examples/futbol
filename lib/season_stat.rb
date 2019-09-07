module SeasonStat

  # def team_info(team_id)
  #   team_info_hash = Hash.new
  #   team_info_hash["team_id"] = team_id
  #   team_info_hash["franchise_id"] = all_teams[team_id].franchise_id
  #   team_info_hash["team_name"] = all_teams[team_id].team_name
  #   team_info_hash["abbreviation"] = all_teams[team_id].abbreviation
  #   team_info_hash["link"] = all_teams[team_id].link
  #   team_info_hash
  # end

  def seasons_to_game_teams(team_id)
    # find game_id in game_teams via team_id
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
    end
    best_season_var[0]
  end
end
