module Leagueable

  def count_of_teams
    teams.length
  end

  def best_offense
    best_offense_team = teams.values.max_by do |team|
      team.total_goals/team.games.length.to_f
    end
    best_offense_team.name
  end

  def worst_offense
    worst_offense_team = teams.values.min_by do |team|
      team.total_goals/team.games.length.to_f
    end
    worst_offense_team.name
  end

  def best_defense
    best_defense_team = teams.values.min_by do |team|
      team.total_goals_allowed/team.games.length.to_f
    end
    best_defense_team.name
  end

  def worst_defense
    worst_defense_team = teams.values.max_by do |team|
      team.total_goals_allowed/team.games.length.to_f
    end
    worst_defense_team.name
  end

  def highest_scoring_visitor
    best_visitor = teams.values.max_by do |team|
      team.total_away_goals/team.total_away_games.to_f
    end
    best_visitor.name
  end

  def highest_scoring_home_team
    best_home_team = teams.values.max_by do |team|
      team.total_home_goals/team.total_home_games.to_f
    end
    best_home_team.name
  end

  def lowest_scoring_visitor
    worst_visitor = teams.values.min_by do |team|
      team.total_away_goals/team.total_away_games.to_f
    end
    worst_visitor.name
  end

  def lowest_scoring_home_team
    worst_home_team = teams.values.min_by do |team|
      team.total_home_goals/team.total_home_games.to_f
    end
    worst_home_team.name
  end

  def winningest_team
    winningest = teams.values.max_by do |team|
      team.total_wins/team.games.length.to_f
    end
    winningest.name
  end

  def best_fans

  end

  def worst_fans
    
  end
end
