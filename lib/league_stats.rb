module LeagueStats
  def total_number_of_teams
    teams = game_manager.games.flat_map do |game|
      [game.away_team_id, game.home_team_id]
    end
    teams.uniq.count
  end

  def calculate_best_offense
    best_offense = game_manager.team_stats.max_by do |team, stats|
      stats[:total_goals] / stats[:total_games].to_f
    end
    find_team_by_team_id(best_offense[0])
  end

  def calculate_worst_offense
    worst_offense = game_manager.team_stats.min_by do |team, stats|
      stats[:total_goals] / stats[:total_games].to_f
    end
    find_team_by_team_id(worst_offense[0])
  end

  def calculate_highest_scoring_visitor
    highest_scoring_visitor = game_manager.team_stats.max_by do |team, stats|
      stats[:away_goals] / stats[:away_games].to_f
    end
    find_team_by_team_id(highest_scoring_visitor[0])
  end

  def calculate_highest_scoring_home_team
    highest_scoring_home_team = game_manager.team_stats.max_by do |team, stats|
      stats[:home_goals] / stats[:home_games].to_f
    end
    find_team_by_team_id(highest_scoring_home_team[0])
  end

  def calculate_lowest_scoring_visitor
    lowest_scoring_visitor = game_manager.team_stats.min_by do |team, stats|
      stats[:away_goals] / stats[:away_games].to_f
    end
    find_team_by_team_id(lowest_scoring_visitor[0])
  end

  def calculate_lowest_scoring_home_team
    lowest_scoring_home_team = game_manager.team_stats.min_by do |team, stats|
      stats[:home_goals] / stats[:home_games].to_f
    end
    find_team_by_team_id(lowest_scoring_home_team[0])
  end
end