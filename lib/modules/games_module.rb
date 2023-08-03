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
    # require 'pry';binding.pry
  end

  def team_goals
    gamez = Hash.new(0)
    League.games.each do |game|
      gamez[game.home_team_id] += game.home_team_goals
      gamez[game.away_team_id] += game.away_team_goals
    end
    gamez
  end
end