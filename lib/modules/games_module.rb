require './lib/helper_class'

module Games
  def best_offense
    # team_goals
    # most_goals_team_id = team_goals.key(team_goals.values.max)
    grouped_home_teams = League.games.group_by(&:home_team_id)
    home_goals_by_team = grouped_home_teams.transform_values { |game| game.sum(&:home_team_goals) }

    grouped_away_teams = League.games.group_by(&:away_team_id)
    away_goals_by_team = grouped_away_teams.transform_values { |game| game.sum(&:away_team_goals) }

    total_goals_by_team = home_goals_by_team.merge(away_goals_by_team) { |team_id, home_goals, away_goals| home_goals + away_goals }

    home_games_per_team = League.games.group_by(&:home_team_id).transform_values(&:count)
    away_games_per_team = League.games.group_by(&:away_team_id).transform_values(&:count)
    total_games_per_team = home_games_per_team.merge(away_games_per_team) { |team_id, home_games, away_games| home_games + away_games }

    average_goals_per_home_team = home_goals_by_team.transform_values do |goals|
      team_id = home_goals_by_team.key(goals)
      goals.to_f / home_games_per_team[team_id]
    end
    
    highest_average_home_goals_id = average_goals_per_home_team.key(average_goals_per_home_team.values.max)

    require 'pry';binding.pry

    # Team.teams_lookup[most_goals_team_id]
  end

  # def worst_offense
  #   team_goals
  #   worst_goals_team_id = team_goals.key(team_goals.values.min)
  #   Team.teams_lookup[worst_goals_team_id]
  # end

  # def highest_scoring_home_team
  #   grouped_home = League.games.group_by(&:home_team_id)
  #   tally_results = grouped_home.transform_values { |games| games.sum(&:home_team_goals) }
  #   # require 'pry';binding.pry
  # end

  # def team_goals
  #   # goals_team = Hash.new(0)
  #   # League.games.each do |game|
  #   #   goals_team[game.home_team_id] += game.home_team_goals
  #   #   goals_team[game.away_team_id] += game.away_team_goals
  #   # end
  #   # goals_team

  #   Leagues.games.each_with_object({}) { |games| games.include? }
  # end
end