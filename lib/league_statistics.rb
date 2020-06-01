module LeagueStatistics
  
  def count_of_teams
    @teams.count
  end


# Team Statistics
  def team_info(team_id)
    @teams.reduce({}) do |info, team|
      if team_id == team.team_id
        info["team_id"] = team.team_id
        info["franchise_id"] = team.franchiseid
        info["team_name"] = team.teamname
        info["abbreviation"] = team.abbreviation
        info["link"] = team.link
      end
      info
    end
  end
# Name of the opponent that has the lowest win percentage against the given team.
  def all_games_by_team(team_id) # find all games that match team id
    @game_teams.find_all do |all_games|
      all_games.team_id == team_id
    end
  end

  def all_opponents_stats(team_id)
    game_ids = all_games_by_team(team_id).map do |game|
      game.game_id
    end
    opponent_stats = []
    @game_teams.each do |game_team|
      opponent_stats << game_team if (game_ids.include?(game_team.game_id) && game_team.team_id != team_id)
    end
    opponent_stats
  end

  def win_percentage_against(team_id)
    grouped_by_team = all_opponents_stats(team_id).group_by do |stat|
      stat.team_id
    end
    win_percent = {}
    grouped_by_team.each do |team_id, games|
      loss = 0
      percent = 0
      games.each do |game|
        loss += 1 if game.result == "WIN"
      end
      win_percent[team_id] = percent += (loss.to_f/games.count).round(2)
    end
    win_percent
  end

  def favorite_opponent(team_id)
    opponent = win_percentage_against(team_id).min_by do |team_id, percent|
      percent
    end[0]
    team_name(opponent)
  end

  def rival(team_id)
    opponent = win_percentage_against(team_id).max_by do |team_id, percent|
      percent
    end[0]
    team_name(opponent)
  end
end
