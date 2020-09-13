module LeagueStatistics
  def count_of_teams
    teams = games.flat_map do |game|
      [game.away_team_id, game.home_team_id]
    end
    teams.uniq.count
  end

  def best_offense
    best_offense = team_stats.max_by do |_team, stats|
      stats[:total_goals] / stats[:total_games].to_f
    end
    find_team_by_team_id(best_offense[0])
  end

  def worst_offense
    worst_offense = team_stats.min_by do |_team, stats|
      stats[:total_goals] / stats[:total_games].to_f
    end
    find_team_by_team_id(worst_offense[0])
  end

  def highest_scoring_visitor
    highest_scoring_visitor = team_stats.max_by do |_team, stats|
      stats[:away_goals] / stats[:away_games].to_f
    end
    find_team_by_team_id(highest_scoring_visitor[0])
  end

  def highest_scoring_home_team
    highest_scoring_home_team = team_stats.max_by do |_team, stats|
      stats[:home_goals] / stats[:home_games].to_f
    end
    find_team_by_team_id(highest_scoring_home_team[0])
  end

  def lowest_scoring_visitor
    lowest_scoring_visitor = team_stats.min_by do |_team, stats|
      stats[:away_goals] / stats[:away_games].to_f
    end
    find_team_by_team_id(lowest_scoring_visitor[0])
  end

  def lowest_scoring_home_team
    lowest_scoring_home_team = team_stats.min_by do |_team, stats|
      stats[:home_goals] / stats[:home_games].to_f
    end
    find_team_by_team_id(lowest_scoring_home_team[0])
  end
end
