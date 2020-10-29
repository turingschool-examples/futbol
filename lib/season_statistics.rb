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

  def worst_coach(season_str, games, game_teams)
    coach_total_wins_by_season(season_str, games, game_teams).min_by do |team_id,hash|
      wins_to_percentage(hash)
    end[0]
  end

  def most_accurate_team(season_str, game, game_teams, teams)
    team_name(most_accurate_team_id(season_str, game, game_teams, teams), teams)
  end

  def shots_and_goals_by_team_id(season_str, game, game_teams)
    shots_and_goals = {}
    game.each do |game_id, game_obj|
      if game_obj.season == season_str
        game_teams[game_id].each do |hoa, game_team_obj|
          shots_and_goals[game_team_obj.team_id] ||= {:goals => 0, :shots => 0}
          shots_and_goals[game_team_obj.team_id][:goals] += game_team_obj.goals
          shots_and_goals[game_team_obj.team_id][:shots] += game_team_obj.shots
        end
      end
    end
    shots_and_goals
  end

  def shot_on_goal_ratio(hash)
    hash[:goals].to_f / hash[:shots]
  end

  def most_accurate_team_id(season_str, game, game_teams, teams)
    shots_and_goals_by_team_id(season_str, game, game_teams).max_by do |team_id, goals_shots|
      shot_on_goal_ratio(goals_shots)
    end[0]
  end

  def team_name(id, teams)
    teams[id.to_s].teamName
  end

end
