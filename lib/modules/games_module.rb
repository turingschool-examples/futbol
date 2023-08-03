require './lib/helper_class'

module Games
  def best_offense
    team_goals
    most_goals_team_id = team_goals.key(team_goals.values.max)
    Team.teams_lookup[most_goals_team_id]
  end

  def worst_offense
    team_goals
    worst_goals_team_id = team_goals.key(team_goals.values.min)
    Team.teams_lookup[worst_goals_team_id]
  end

  def highest_scoring_home_team
    grouped_home = League.games.group_by(&:home_team_id)
    tally_results = grouped_home.transform_values { |games| games.sum(&:home_team_goals) }
    require 'pry';binding.pry
  end

  def team_goals
    goals_team = Hash.new(0)
    League.games.each do |game|
      goals_team[game.home_team_id] += game.home_team_goals
      goals_team[game.away_team_id] += game.away_team_goals
    end
    goals_team 
    # require 'pry';binding.pry
    # goals_team.sort_by { |_, goals| -goals }
  end
end