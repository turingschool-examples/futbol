require './lib/helper_class'

module Games
  def home_goals_by_team
    grouped_home_teams = League.games.group_by(&:home_team_id)
    grouped_home_teams.transform_values { |game| game.sum(&:home_team_goals) }
  end
  
  def away_goals_by_team
    grouped_away_teams = League.games.group_by(&:away_team_id)
    grouped_away_teams.transform_values { |game| game.sum(&:away_team_goals) }
  end
  
  def total_goals_by_team
    home_goals_by_team.merge(away_goals_by_team) { |team_id, home_goals, away_goals| home_goals + away_goals }
  end
  
  def home_games_per_team
    League.games.group_by(&:home_team_id).transform_values(&:count)
  end
  
  def away_games_per_team
    League.games.group_by(&:away_team_id).transform_values(&:count)
  end
  
  def total_games_per_team
    home_games_per_team.merge(away_games_per_team) { |team_id, home_games, away_games| home_games + away_games }
  end
  
  def average_goals_per_home_team
    home_goals_by_team.transform_values do |goals|
      team_id = home_goals_by_team.key(goals)
      goals.to_f / home_games_per_team[team_id]
    end
  end
  
  def average_goals_per_away_team
    away_goals_by_team.transform_values do |goals|
      team_id = away_goals_by_team.key(goals)
      goals.to_f / away_games_per_team[team_id]
    end
  end
  
  def average_goals_per_team
    total_goals_by_team.transform_values do |goals|
      team_id = total_goals_by_team.key(goals)
      goals.to_f / total_games_per_team[team_id]
    end
  end
  
  def best_offense
    highest_average_goals_id = average_goals_per_team.key(average_goals_per_team.values.max)
    Team.teams_lookup[highest_average_goals_id]
  end
  
  def worst_offense
    lowest_average_goals_id = average_goals_per_team.key(average_goals_per_team.values.min)
    Team.teams_lookup[lowest_average_goals_id]
  end
  
  def highest_scoring_home_team
    highest_average_home_goals_id = average_goals_per_home_team.key(average_goals_per_home_team.values.max)
    Team.teams_lookup[highest_average_home_goals_id]
  end
  
  def lowest_scoring_home_team
    lowest_average_home_goals_id = average_goals_per_home_team.key(average_goals_per_home_team.values.min)
    Team.teams_lookup[lowest_average_home_goals_id]
  end
  
  def highest_scoring_visitor
    highest_average_away_goals_id = average_goals_per_away_team.key(average_goals_per_away_team.values.max)
    Team.teams_lookup[highest_average_away_goals_id]
  end
  
  def lowest_scoring_visitor
    lowest_average_away_goals_id = average_goals_per_away_team.key(average_goals_per_away_team.values.min)
    Team.teams_lookup[lowest_average_away_goals_id]
  end
end