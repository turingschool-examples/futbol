module SeasonProcessor
  def coach_stats(game_id_year, game_teams)
    stats = Hash.new { |coach, stats| coach[stats] = [0.0, 0.0] }
    game_teams.each do |game_team|
      if game_team.game_id[0..3] == game_id_year
        stats[game_team.head_coach][0] += 1
        stats[game_team.head_coach][1] += 1 if game_team.result == "WIN"
      end
    end
    return stats
  end

  def best_coach(coach_stats)
    highest_win_percentage = 0.0
    highest_win_percentage_coach = ""
    coach_stats.each do |coach, stats|
      if highest_win_percentage < (stats[1] / stats[0])
        highest_win_percentage = stats[1] / stats[0]
        highest_win_percentage_coach = coach
      end
    end
    highest_win_percentage_coach
  end

  def worstest_coach(coach_stats)
    lowest_win_percentage = Float::INFINITY
    lowest_win_percentage_coach = ""
    coach_stats.each do |coach, stats|
      if lowest_win_percentage > (stats[1] / stats[0])
        lowest_win_percentage = stats[1] / stats[0]
        lowest_win_percentage_coach = coach
      end
    end
    lowest_win_percentage_coach
  end

  def goal_stats(game_id_year, game_teams)
    stats = Hash.new { |team_id, stats| team_id[stats] = [0.0, 0.0] }
    game_teams.each do |game_team|
      if game_team.game_id[0..3] == game_id_year
        stats[game_team.team_id][0] += game_team.shots.to_i
        stats[game_team.team_id][1] += game_team.goals.to_i
      end
    end
    return stats
  end

  def mostest_accurate_team(goal_stats)
    highest_goal_ratio = 0.0
    highest_goal_ratio_team = ""
    goal_stats.each do |team_id, stats|
      if highest_goal_ratio < (stats[1] / stats[0])
        highest_goal_ratio = stats[1] / stats[0]
        highest_goal_ratio_team = team_id
      end
    end
    highest_goal_ratio_team
  end

  def leastest_accurate_team(goal_stats)
    leastest_goal_ratio = Float::INFINITY
    leastest_goal_ratio_team = ""
    goal_stats.each do |team_id, stats|
      if leastest_goal_ratio > (stats[1] / stats[0])
        leastest_goal_ratio = stats[1] / stats[0]
        leastest_goal_ratio_team = team_id
      end
    end
    leastest_goal_ratio_team
  end

  def tackle_stats(game_id_year, game_teams)
    stats = Hash.new(0)
    game_teams.each do |game_team|
      if game_team.game_id[0..3] == game_id_year
        stats[game_team.team_id] += game_team.tackles.to_i
      end
    end
    return stats
  end
end
