module TeamStatistics

  def team_info(team_id)
    team_info = {}
    team = @team_table.fetch(team_id)
    team.instance_variables.each do |instance_variable|
      team_info[instance_variable.to_s.delete(":@")] = team.instance_variable_get(instance_variable)
    end
    team_info.delete("stadium")
    team_info
  end

  def collect_seasons(team_id)
    season_game_id_hash = {}
        @game_table.each do |game_id, game|
          if  season_game_id_hash[game.season].nil? && (team_id.to_i == game.away_team_id || team_id.to_i == game.home_team_id)
             season_game_id_hash[game.season] = [game]
           elsif team_id == game.away_team_id || team_id.to_i == game.home_team_id
             season_game_id_hash[game.season] << game
           end
        end
        collect_wins_per_season(team_id, season_game_id_hash)
  end

  def collect_wins_per_season(team_id, season_game_id_hash)
    wins = 0
    season_game_id_hash.each do |season|
      season[1].each do |game|
        if (team_id.to_i) == game.away_team_id && (game.away_goals > game.home_goals)
          wins += 1
        elsif (team_id.to_i) == game.home_team_id && (game.away_goals < game.home_goals)
          wins += 1
        end
      end
    end
  end




end
