class SeasonStatistics
  
  def winningest_coach(season_str, games, game_teams)
    coach_total_wins_by_season(season_str, games, game_teams).max_by do |team_id,hash|
      wins_to_percentage(hash)
    end[0]
  end

  def coach_total_wins_by_season(season_str, games, game_teams)
    team_wins_by_coach = {}
    games.each do |game_id, game_obj|
      if game_obj.season == season_str
        game_pair_obj = game_teams[game_id]
        game_pair_obj.each do |hoa, game_team|
          team_wins_by_coach[game_team.head_coach] ||= {wins: 0, total: 0}
          team_wins_by_coach[game_team.head_coach][:total] += 1
          if game_team.result == "WIN"
            team_wins_by_coach[game_team.head_coach][:wins] += 1
          end
        end
      end
    end
    team_wins_by_coach
  end

  def wins_to_percentage(hash)
    hash[:wins].to_f / hash[:total]
  end

end
