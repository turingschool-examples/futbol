class SeasonStatistics
# 1. combine 2 iterations into 1
# hash team => wins
  def winningest_coach(season_str, data, data1)
    team_total_wins_by_season(season_str, data, data1)
  end

  def team_total_wins_by_season(season_str, data, data1)
    team_wins_by_season = {}
    data.each do |season, game_obj|
      if game_obj.season == season_str
        team_wins_by_season[game_obj.home_team_id] ||= {wins: 0, total: 0}
        team_wins_by_season[game_obj.away_team_id] ||= {wins: 0, total: 0}
        team_wins_by_season[game_obj.home_team_id][:total] += 1
        team_wins_by_season[game_obj.away_team_id][:total] += 1
        if game_obj.away_goals > game_obj.home_goals
          team_wins_by_season[game_obj.away_team_id][:wins] += 1
        elsif game_obj.away_goals < game_obj.home_goals
          team_wins_by_season[game_obj.home_team_id][:wins] += 1
        end
      end
    end
    team_wins_by_season
  end

  # def method_name
  #
  # end

end
